module ESPN
  class Client
    module Now

      # Public: Get stream of the latest content published on ESPN.com.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :method   - The type of content to retrieve (default: nil).
      #
      # Returns an Array of Hashie::Mash
      def now(opts={})
        url = 'now'

        unless opts[:method].to_s.empty?
          url += "/#{opts[:method]}"
        end

        get(url, opts)
      end

    end
  end
end
