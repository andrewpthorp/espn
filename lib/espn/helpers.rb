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

  end

end
