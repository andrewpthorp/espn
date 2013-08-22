module ESPN
  class Client
    module Audio

      # Public: Get audio podcasts and clips from ESPN.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :method         - The name of the sport (default: 'podcasts').
      #       - :podast_id      - The id of the podcast (default: nil).
      #       - :recording_id   - The id of the recording (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def audio(opts={})
        opts [:method] ||= 'podcasts'

        url = 'audio'

        if opts[:method] == 'podcast_recordings'
          url += '/podcasts/recordings'
        else
          url += "/#{opts[:method]}"
        end

        unless opts[:podcast_id].to_s.empty?
          url += "/#{opts[:podcast_id]}"
        end

        unless opts[:recording_id].to_s.empty?
          url += "/#{opts[:recording_id]}"
        end

        get(url, opts)
      end

    end
  end
end
