module ESPN

  # Public: Commonly used Helpers are defined in this module.
  #
  # Examples
  #
  #   class Client
  #     include ESPN::Helpers
  #   end
  module Helpers

    # Public: If the last item of the args Array is a Hash, pop it off and
    # return it. If the last item of the args Array is not a Hash, return a new
    # Hash. This works similar to the Rails ActiveSupport #extract_options! but
    # it does not alter the Array class, and handles setting optional defaults.
    #
    # args      - The Array that we want to pop the Hash off of.
    # defaults  - Hash that sets default values if they don't exist.
    #
    # Examples
    #
    #   extract_options_with_defaults!([{ foo: 'bar' }])
    #   # => { foo: 'bar' }
    #
    #   extract_options_with_defaults!([], foo: 'default')
    #   # => { foo: 'default' }
    #
    #   extract_options_with_defaults!([{ foo: 'bar' }], foo: 'default')
    #   # => { foo: 'bar' }
    #
    # Returns a Hash.
    def extract_options_with_defaults!(args, defaults={})
      options = {}

      # Pop options from args if it exists.
      if args.last.is_a? Hash
        options = args.pop
      end

      # Only replace options with defaults if it is nil.
      options.merge!(defaults) { |key, v1, v2| v1 }

      return options
    end

    # Public: Determine if a given Object is blank? If it is a String, or anything
    # that responds to :empty?, it will use that method. If it does not respond to
    # :empty? it will check that the Object is not nil.
    #
    # object  - The Object to check for blank.
    #
    # Examples
    #
    #   blank?('')
    #   # => true
    #
    #   blank?('foo')
    #   # => false
    #
    #   blank?(nil)
    #   # => true
    #
    #   blank?(Object.new)
    #   # => false
    #
    # Returns a Boolean.
    def blank?(object)
      object.respond_to?(:empty?) ? object.empty? : !object
    end

  end

end
