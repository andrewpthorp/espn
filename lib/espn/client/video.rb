module ESPN
  class Client

    # Public: The mapping to the VIDEO API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Video
    #   end
    module Video

      # Public: Get video clip and channel information from ESPN.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :category_id  - The id of the category (default: nil).
      #       - :clip_id      - The id of the clip (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def videos(opts={})
        # Build URL
        pattern = 'video/channels/:category_id/clips/:clip_id'
        url = build_url(pattern, opts)

        # Make request
        get(url, opts).channels
      end

    end
  end
end
