module ESPN
  class Client
    module Notes

      # Public: Get Exclusive factoids produced by ESPN's Stats and Information
      # Group from the ESPN API.
      #
      # opts  - Hash options used to refine the selection (default: {}).
      #       - :sport    - The name of the sport (default: nil).
      #       - :league   - The name of the league (default: nil).
      #       - :note_id  - The id of the note (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def notes(opts={})
        url = 'sports'

        unless opts[:sport].to_s.empty?
          url += "/#{opts[:sport]}"
          unless opts[:league].to_s.empty?
            url += "/#{opts[:league]}"
          end
        end

        url += '/news/notes'

        unless opts[:note_id].to_s.empty?
          url += "/#{opts[:note_id]}"
        end

        get(url, opts)
      end

    end
  end
end
