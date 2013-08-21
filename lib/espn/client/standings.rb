module ESPN
  class Client
    module Standings

      # Public: Get the latest league and divisional standings from ESPN.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :sport    - The name of the sport (default: nil).
      #       - :league   - The name of the league (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def standings(opts={})
        url = 'sports'

        unless opts[:sport].to_s.empty?
          url += "/#{opts[:sport]}"
          unless opts[:league].to_s.empty?
            url += "/#{opts[:league]}"
          end
        end

        url += '/standings'

        get(url, opts)
      end

    end
  end
end
