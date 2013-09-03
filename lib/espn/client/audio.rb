module ESPN
  class Client

    # Public: The mapping to the AUDIO API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Audio
    #   end
    module Audio

      # Public: Get audio podcasts and clips from ESPN.
      #
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           You can find a full list of options on the ESPN developer API
      #           website (default: {}).
      #           :method       - The name of the sport (default: 'podcasts').
      #           :podcast_id   - The id of the podcast (default: nil).
      #           :recording_id - The id of the recording (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def audio(opts={})
        opts[:method] ||= 'podcasts'

        # Correct invalid method.
        if opts[:method] == 'podcast_recordings'
          opts[:method] = 'podcasts/recordings'
        end

        # Build URL
        pattern = "audio/#{opts[:method]}/:podcast_id/:recording_id/"
        url = build_url(pattern, opts)

        # Make request
        get(url, opts).recordings
      end

    end
  end
end
