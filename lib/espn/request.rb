require 'multi_json'
require 'faraday_middleware'
require 'faraday/response/raise_espn_error'

module ESPN

  # Public: Make the request magic happen. This module gets included and only
  # exposes one method to the public interface: #get.
  #
  # Examples
  #
  #   class Client
  #     include ESPN::Request
  #   end
  module Request

    # Public: Make an HTTP GET Request to the path, passing the opts as params
    # in the query.
    #
    # pattern - A String to build a URL from.
    # opts    - A Hash to send as query parameters (default: {}).
    #
    # Returns a String.
    def get(pattern, opts={})
      path = build_url(pattern, opts)
      request(:get, path, opts)
    end

    private

    # Internal: Use the Faraday::Connection from lib/espn/connection.rb and
    # make the HTTP Request to the path.
    #
    # method  - A Symbol specifying the HTTP method to use.
    # path    - The URL to send the request to.
    # opts    - The Hash options to send as query parameters.
    #
    # Returns a String.
    def request(method, path, opts)

      # TODO: Decide if I want to delete these or not. There is probably
      # a better way to do this, if so, by filtering them out.
      %w(
        sport league method section id team_id headline_id category_id
        clip_id athlete_id event_id note_id podcast_id recording_id
      ).each do |k|
        opts.delete(k.to_sym)
      end

      response = connection.send(method) do |request|
        request.url(path, opts)
        request.options[:timeout] = timeout
        request.options[:open_timeout] = open_timeout
      end

      response.body
    end

    # Internal: Build a new instance of Faraday with some default options and
    # return it.
    #
    # Returns a Faraday::Connection.
    def connection
      options = { proxy: proxy, ssl: { verify: false }, url: api_url }
      options.merge!(params: { apikey: api_key }) if authed?

      connection = Faraday.new(options) do |builder|
        builder.use Faraday::Response::RaiseESPNError
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson
        builder.adapter adapter
      end

      connection
    end

    # Internal: Takes a pattern and a Hash of fragments and constructs a url.
    # If the fragments include a league but not a sport, the league will be
    # deleted from the Hash so it does not get sent along.
    #
    # pattern   - The pattern to match fragments against.
    # fragments - The Array of fragments to apply to the pattern.
    #
    # Returns a String.
    def build_url(pattern, fragments)

      # Only allow league if sport is passed in.
      fragments.delete(:league) if fragments[:sport].to_s.empty?

      # Remove the /headlines section if fragments does not include a :method.
      # This is due to the HEADLINES API being a little strange.
      unless fragments.include? :method
        pattern.gsub!('headlines', '')
      end

      template = URITemplate.new(:colon, pattern)
      url = template.expand(fragments)

      # Remove duplicate slashes (if any)
      url = url.gsub(/\/{2,}/,'/')

      # Remove trailing slash (if any)
      url = url.gsub(/\/+$/, '')

      url
    end

  end
end
