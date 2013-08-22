module ESPN
  class Client
    module Video

      # Public: Get video clip and channel information from ESPN.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :category_id  - The id of the category (default: nil).
      #       - :clip_id      - The id of the clip (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def video(opts={})
        url = 'video/channels'

        unless opts[:category_id].to_s.empty?
          url += "/#{opts[:category_id]}"
        end

        url += '/clips'

        unless opts[:clip_id].to_s.empty?
          url += "/#{opts[:clip_id]}"
        end

        puts url

        get(url, opts)
      end

    end
  end
end
