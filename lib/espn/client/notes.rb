module ESPN
  class Client

    # Public: The mapping to the RESEARCH NOTES API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Notes
    #   end
    module Notes

      # Public: Get Exclusive factoids produced by ESPN's Stats and Information
      # Group from the ESPN API.
      #
      # sport   - A Symbol or String of the sport (optional).
      # league  - A Symbol or String of the league. If a league is passed, but
      #           not a sport, an attempt will be made to map the league to a
      #           sport (required).
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           You can find a full list of options on the ESPN developer API
      #           website (default: {}).
      #           - :id - The id of a specific note (default: nil, optional).
      #
      # Returns an Array of Hashie::Mash.
      def notes(*args)
        # Build fragments and options
        opts = extract_options_with_defaults!(args)
        opts[:sport], opts[:league] = extract_sport_and_league(args, opts)

        # Build URL
        pattern = "sports/:sport/:league/news/notes/:id"
        url = build_url(pattern, opts)

        # Make request
        get(url, opts).notes
      end

    end
  end
end
