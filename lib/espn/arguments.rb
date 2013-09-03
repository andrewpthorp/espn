require 'espn/mapper'

module ESPN

  # Internal: Extract options from method arguments.
  class Arguments < Array
    include ESPN::Mapper

    # Public: Gets the options Hash.
    attr_reader :options

    # Public: Initialize an instance of Arguments.
    #
    # args      - The Array of arguments passed into a method.
    # defaults  - The Hash of default values for the options.
    def initialize(args, defaults={})
      @options = args.last.is_a?(::Hash) ? args.pop : {}

      # Set defaults, only if the value in @options is nil.
      @options.merge!(defaults) { |k, v1, v2| v1 }

      # Extract sport and league
      @options[:sport], @options[:league] =
        extract_sport_and_league(args, @options)

      super(args)
    end

  end

end
