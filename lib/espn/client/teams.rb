module ESPN
  class Client
    module Teams

      # Public: Get sport team stats and information from the ESPN API.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :sport    - The name of the sport (default: nil).
      #       - :league   - The name of the league (default: nil).
      #       - :team_id  - The id of the team (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def teams(opts={})
        url = "sports"

        unless opts[:sport].to_s.empty?
          url += "/#{opts[:sport]}"
          unless opts[:league].to_s.empty?
            url += "/#{opts[:league]}"
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
