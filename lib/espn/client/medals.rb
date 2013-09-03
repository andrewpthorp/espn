module ESPN
  class Client

    # Public: The mapping to the MEDALS API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Medals
    #   end
    module Medals

      # Public: Get medal counts and competition from the olympic games.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #
      # Returns an Array of Hashie::Mash.
      def medals(opts={})
        get('sports/olympics/medals', opts)
      end

    end
  end
end
