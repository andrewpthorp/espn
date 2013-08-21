require 'faraday'
require 'espn/version'

module ESPN

  # Public: All methods useful for configuration. This module should be extended
  # in the ESPN module, so ESPN can be configured.
  #
  # Examples
  #
  #   module ESPN
  #     extend Configuration
  #   end
  module Configuration

    # Public: Array of all configuration options for an ESPN::Client.
    VALID_OPTIONS_KEYS = [:adapter, :api_version, :proxy, :api_key, :timeout,
                          :open_timeout, :user_agent].freeze

    # Public: The default adapter used for requests.
    DEFAULT_ADAPTER         = Faraday.default_adapter

    # Public: The default API Version.
    DEFAULT_API_VERSION     = 1

    # Public: The default user agent.
    DEFAULT_USER_AGENT      = "ESPN Ruby Gem #{ESPN::VERSION}".freeze

    # Public: The default timeout for HTTP Requests.
    DEFAULT_TIMEOUT         = 10

    # Public: Create an attr_accessor for each VALID_OPTIONS_KEYS when this
    # module is extended into another.
    attr_accessor(*VALID_OPTIONS_KEYS)

    # Internal: Hook when this module is extended in another, we call #reset.
    #
    # Returns nothing.
    def self.extended(base)
      base.reset
    end

    # Public: The ability to configure ESPN default options.
    #
    # Examples
    #
    #   ESPN.configure do |c|
    #     c.api_key = 'abc123'
    #   end
    #
    # Yields ESPN::Configuration.
    def configure
      yield self
    end

    # Public: Get all valid options with their defaults.
    #
    # Returns a Hash.
    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    # Public: Reset all valid options to their defaults.
    #
    # Returns nothing.
    def reset
      self.adapter                = DEFAULT_ADAPTER
      self.api_version            = DEFAULT_API_VERSION
      self.user_agent             = DEFAULT_USER_AGENT
      self.timeout                = DEFAULT_TIMEOUT
      self.open_timeout           = DEFAULT_TIMEOUT
      self.api_key                = nil
      self.proxy                  = nil
    end
  end
end
