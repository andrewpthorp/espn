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
      # channel_id  - The id of a video channel.
      # opts        - Hash options used to refine the selection (default: {}).
      #               :clip_id - The id of the clip (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def videos(channel_id, opts={})
        # Build URL
        pattern = "video/channels/#{channel_id}/clips/:clip_id"
        url = build_url(pattern, opts)

        # Make request
        get(url, opts).channels
      end

    end
  end
end
