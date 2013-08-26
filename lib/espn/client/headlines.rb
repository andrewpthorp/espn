module ESPN
  class Client

    # Public: The mapping to the HEADLINES API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Headlines
    #   end
    module Headlines

      # Public: Get latest sports news and analysis from the ESPN API.
      #
      # sport   - A Symbol or String of the sport (optional).
      # league  - A Symbol or String of the league. If a league is passed, but
      #           not a sport, an attempt will be made to map the league to a
      #           sport (optional).
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           (default: {}).
      #           - :section  - The news section (default: 'sports').
      #           - :sport    - Name of the sport (default: nil, optional).
      #           - :league   - Name of the league (default: nil, optional).
      #           - :method   - Method of headlines (default: nil, optional).
      #           - :id       - Specific headline ID (default: nil, optional).
      #
      # Examples
      #
      #   client.headlines(:mlb)
      #   # Request made to 'sports/baseball/mlb/news'
      #
      #   client.headlines('baseball')
      #   # Request will be made to 'sports/baseball/news'
      #
      #   client.headlines('horse-racing', :mlb)
      #   # Request will be made to 'sports/horse-racing/mlb/news'
      #
      #   client.headlines(:mlb, sport: 'basketball')
      #   # Request will be made to 'sports/basketball/mlb/news'
      #
      #   client.headlines(:baseball, :mlb, sport: 'basketball', league: 'nba')
      #   # Request will be made to 'sports/basketball/nba/news'
      #
      # Returns an Array of Hashie::Mash.
      def headlines(*args)
        # Build fragments and options
        opts = extract_options!(args)
        opts[:section] ||= 'sports'

        # Extract League/Sport
        sport, league = extract_sport_and_league(args)
        opts[:league] ||= league
        opts[:sport] ||= sport

        # Build URL
        pattern = "#{opts[:section]}/:sport/:league/news/headlines/:method/:id"
        url = build_url(pattern, opts)

        # Make request
        get(url, opts)
      end

    end
  end
end
