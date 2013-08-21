module ESPN
  class Client
    module Sports

      # Public: Get all sports supported by the ESPN Developer API
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :sports_name  - The name of the sport.
      #       - :league_name - The name of the league.
      #
      # Returns an Array of Hashie::Mash.
      def sports(opts={})
        url = 'sports'

        unless opts[:sports_name].to_s.empty?
          url += "/#{opts[:sports_name]}"
          unless opts[:league_name].to_s.empty?
            url += "/#{opts[:league_name]}"
          end
        end

        get(url, opts)
      end

    end
  end
end
