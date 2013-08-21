module ESPN
  class Client
    module Athletes

      # Public: Get athlete stats and information from the ESPN API.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :sport        - The name of the sport (default: nil).
      #       - :league       - The name of the league (default: nil).
      #       - :athlete_id   - The id of the athlete (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def athletes(opts={})
        url = "sports"

        unless opts[:sport].to_s.empty?
          url += "/#{opts[:sport]}"
          unless opts[:league].to_s.empty?
            url += "/#{opts[:league]}"
          end
        end

        url += "/athletes"

        unless opts[:athlete_id].to_s.empty?
          url += "/#{opts[:athlete_id]}"
        end

        get(url, opts)
      end

    end
  end
end
