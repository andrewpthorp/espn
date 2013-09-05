module ESPN
  class Client

    # Public: The mapping to the TEAMS API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Teams
    #   end
    module Teams

      # Public: Get a specific team from the ESPN API.
      #
      # id      - An id of a team.
      # sport   - A Symbol or String of the sport (optional).
      # league  - A Symbol or String of the league. If a league is passed, but
      #           not a sport, an attempt will be made to map the league to a
      #           sport (required).
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           You can find a full list of options on the ESPN developer API
      #           website (default: {}).
      #
      # Returns a Hashie::Mash.
      def team(id, *args)
        args = ESPN::Arguments.new(args, {}, [:league])
        pattern = "sports/:sport/:league/teams/#{id}"
        get(pattern, args.options).sports.first.leagues.first.teams.first
      end

      # Public: Get sport team stats and information from the ESPN API.
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
      def teams(*args)
        args = ESPN::Arguments.new(args, {}, [:league])
        pattern = 'sports/:sport/:league/teams'
        get(pattern, args.options).sports.first.leagues.first.teams
      end

    end
  end
end
