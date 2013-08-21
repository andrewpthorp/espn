module ESPN
  class Client
    module Scores

      # Public: Get schedule and scores information from the ESPN API.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :sport    - The name of the sport (default: nil).
      #       - :league   - The name of the league (default: nil).
      #       - :event_id - The event to get information about (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def scores(opts={})
        url = 'sports'

        unless opts[:sport].to_s.empty?
          url += "/#{opts[:sport]}"
          unless opts[:league].to_s.empty?
            url += "/#{opts[:league]}"
          end
        end

        url += '/events'

        unless opts[:event_id].to_s.empty?
          url += "/#{opts[:event_id]}"
        end

        get(url, opts)
      end

    end
  end
end
