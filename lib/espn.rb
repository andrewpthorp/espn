require 'espn/configuration'
require 'espn/client'
require 'espn/error'
require 'uri_template'

module ESPN
  extend Configuration

  class << self

    # Public: An alias for ESPN::Client.new.
    #
    # Returns an ESPN::Client.
    def new(options={})
      ESPN::Client.new(options)
    end

    # Public: Delegate methods to ESPN::Client.new. If a ESPN::Client does not
    # respond_to? the :method, pass it up the chain.
    #
    # Returns nothing.
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    # Public: Delegate to ESPN::Client.new respond_to?
    #
    # Returns nothing.
    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end

  end

end
