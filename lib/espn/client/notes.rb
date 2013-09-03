module ESPN
  class Client

    # Public: The mapping to the RESEARCH NOTES API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Notes
    #   end
    module Notes

      # Public: Get a specific note from the ESPN developer API.
      #
      # id    - The id of a specific note.
      # opts  - Hash options used to refine the selection. You can find a full
      #         list of options on the ESPN developer API website (default: {}).
      #
      # Returns a Hashie::Mash.
      def note(id, opts={})
        get("sports/news/notes/#{id}", opts).notes.first
      end

      # Public: Get Exclusive factoids produced by ESPN's Stats and Information
      # Group from the ESPN API.
      #
      # sport   - A Symbol or String of the sport (optional).
      # league  - A Symbol or String of the league. If a league is passed, but
      #           not a sport, an attempt will be made to map the league to a
      #           sport (required).
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           You can find a full list of options on the ESPN developer API
      #           website (default: {}).
      #
      # Returns an Array of Hashie::Mash.
      def notes(*args)
        arguments = ESPN::Arguments.new(args)

        # Build URL
        pattern = "sports/:sport/:league/news/notes"
        url = build_url(pattern, arguments.options)

        # Make request
        get(url, arguments.options).notes
      end

    end
  end
end
