require 'espn/connection'
require 'espn/request'

module ESPN

  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = ESPN.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    # Provides the URL for accessing the API
    #
    # @return [String]
    def api_url
      "http://api.espn.com/v1"
    end

    # Determine if an api_key has been set
    #
    # @return [Boolean]
    def authed?
      !api_key.nil?
    end

    include ESPN::Connection
    include ESPN::Request

  end

end
