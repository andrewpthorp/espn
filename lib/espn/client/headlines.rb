module ESPN
  class Client
    module Headlines

      # Public: Get latest sports news and analysis from the ESPN API.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :section      - The news section (default: 'sports').
      #       - :sport        - The name of the sport (default: nil).
      #       - :league       - The name of the league (default: nil).
      #       - :method       - The method of headlines (default: nil).
      #       - :headline_id  - The id of a specific headline (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def headlines(opts={})
        url = opts[:section] || 'sports'

        unless opts[:sport].to_s.empty?
          url += "/#{opts[:sport]}"
          unless opts[:league].to_s.empty?
            url += "/#{opts[:league]}"
          end
        end

        url += '/news'

        unless opts[:method].to_s.empty?
          url += "/headlines/#{opts[:method]}"
        end

        unless opts[:headline_id].to_s.empty?
          url += "/#{opts[:headline_id]}"
        end

        get(url, opts)
      end

    end
  end
end
