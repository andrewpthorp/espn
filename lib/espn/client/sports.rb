module ESPN
  class Client

    # Public: The mapping to the SPORTS API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Sports
    #   end
    module Sports

      # Public: Get sports and leagues supported in the ESPN API.
      #
      # sport   - A Symbol or String of the sport (optional).
      # league  - A Symbol or String of the league. If a league is passed, but
      #           not a sport, an attempt will be made to map the league to a
      #           sport (required).
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           You can find a full list of options on the ESPN developer API
      #           website (default: {}).
      #
      # Returns an Array of Hashie::Mash.
      def sports(*args)
        # Build fragments and options
        opts = extract_options_with_defaults!(args)
        opts[:sport], opts[:league] = extract_sport_and_league(args, opts)

        # Build URL
        pattern = 'sports/:sport/:league'
        url = build_url(pattern, opts)

        # Make request
        get(url, opts).sports
      end

    end
  end
end
