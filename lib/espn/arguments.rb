require 'espn/mapper'
require 'espn/helpers'

module ESPN

  # Internal: Extract options from method arguments.
  class Arguments < Array
    include ESPN::Mapper
    include ESPN::Helpers

    # Public: Gets the options Hash.
    attr_reader :options

    # Public: Initialize an instance of Arguments.
    #
    # args      - The Array of arguments passed into a method.
    # defaults  - The Hash of default values for the options (default: {}).
    # required  - The Array of fields that are required (default: []).
    def initialize(args, defaults={}, required=[])
      @options = args.last.is_a?(::Hash) ? args.pop : {}

      # Set defaults, only if the value in @options is nil.
      @options.merge!(defaults) { |k, v1, v2| v1 }

      # Extract sport and league
      @options[:sport], @options[:league] =
        extract_sport_and_league(args, @options)

      # Validate required fields
      required.each do |field|
        if blank?(@options[field.to_sym])
          raise ArgumentError, "You must supply a valid #{field}."
        end
      end

      super(args)
    end

  end

end
