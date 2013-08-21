module ESPN
  class Client
    module Teams

      # Public: Get all teams supported by the ESPN Developer API
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :sports_name  - The name of the sport.
      #       - :league_name  - The name of the league.
      #       - :team_id      - The id of the team.
      #
      # Returns an Array of Hashie::Mash.
      def teams(opts={})
        url = "sports"

        unless opts[:sports_name].to_s.empty?
          url += "/#{opts[:sports_name]}"
          unless opts[:league_name].to_s.empty?
            url += "/#{opts[:league_name]}"
          end
        end

        url += "/teams"

        unless opts[:team_id].to_s.empty?
          url += "/#{opts[:team_id]}"
        end

        get(url, opts)
      end

    end
  end
end
