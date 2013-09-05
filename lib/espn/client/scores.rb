module ESPN
  class Client

    # Public: The mapping to the SCORES & SCHEDULES API of the ESPN developer
    # API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Scores
    #   end
    module Scores

      # Public: Get the score for a specific event from the ESPN API.
      #
      # id    - The id of an event to get the scores for.
      # opts  - Hash options used to refine the selection. You can find a full
      #         list of options on the ESPN developer API website (default: {}).
      #
      # Returns a Hashie::Mash.
      def score(id, opts={})
        get("sports/events/#{id}", opts).sports.first.leagues.first.events.first
      end

      # Public: Get schedule and scores information from the ESPN API.
      #
      # sport   - A Symbol or String of the sport (optional).
      # league  - A Symbol or String of the league. If a league is passed, but
      #           not a sport, an attempt will be made to map the league to a
      #           sport (required).
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           You can find a full list of options on the ESPN developer API
      #           website (default: {}).
      #           :id - The id of a specific event (default: nil, optional).
      #
      # Returns an Array of Hashie::Mash.
      def scores(*args)
        args = ESPN::Arguments.new(args)
        pattern = 'sports/:sport/:league/events/:id'
        get(pattern, args.options).sports.first.leagues.first.events
      end

    end
  end
end
