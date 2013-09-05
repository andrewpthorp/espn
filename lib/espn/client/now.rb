module ESPN
  class Client

    # Public: The mapping to the ESPN NOW API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Now
    #   end
    module Now

      # Public: Get stream of the latest content published on ESPN.com.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #         :method - The type of content to retrieve (default: nil).
      #
      # Returns a Hashie::Mash. There is always an array of stories in #feed.
      # If there is any breaking news, it will be in #breakingNews.
      def now(opts={})
        pattern = 'now/:method'
        get(pattern, opts)
      end

    end
  end
end
