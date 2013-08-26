require 'faraday'
require 'multi_json'

module Faraday

  # Internal: Faraday Middleware that deals with errors coming back from the API.
  #
  # Examples
  #
  #   conn = Faraday.new({}) do |builder|
  #     builder.use Faraday::Response::RaiseESPNError
  #   end
  class Response::RaiseESPNError < Response::Middleware

    # Internal: Hook into the complete callback for the client. When the result
    # comes back, if it is a status code that we want to raise an error for, we
    # will do that.
    #
    # Raises ESPN::Unauthorized and ESPN::Notfound.
    # Returns nothing.
    def on_complete(response)
      case response[:status].to_i
      when 401
        raise ESPN::Unauthorized, error_message(response)
      when 404
        raise ESPN::NotFound, error_message(response)
      end
    end

    # Internal: Parse the response and return a human friendly String
    # representing the error that we received.
    #
    # Returns a String.
    def error_message(response)
      message = if (body = response[:body]) && !body.empty?
        if body.is_a?(String)
          body = MultiJson.load(body, :symbolize_keys => true)
        end
        ": #{body[:error] || body[:message] || ''}"
      else
        ''
      end
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{message}"
    end
  end

end
