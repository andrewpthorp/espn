module ESPN
  class Client
    module Sports

      # Public: Get sports and leagues supported in the ESPN API.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :sport - The name of the sport (default: nil).
      #       - :league - The name of the league (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def sports(opts={})
        url = 'sports'

        unless opts[:sport].to_s.empty?
          url += "/#{opts[:sport]}"
          unless opts[:league].to_s.empty?
            url += "/#{opts[:league]}"
          end
        end

        get(url, opts)
      end

    end
  end
end
