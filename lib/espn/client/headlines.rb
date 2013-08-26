module ESPN
  class Client
    module Headlines

      # Public: Get latest sports news and analysis from the ESPN API.
      #
      # opts  - Hash options used to refine the selection. If sport and/or
      #         league are passed in, they will override the mapped values
      #         (default: {}).
      #         - :section  - The news section (default: 'sports').
      #         - :sport    - The name of the sport (default: nil).
      #         - :league   - The name of the league (default: nil).
      #         - :method   - The method of headlines (default: nil).
      #         - :id       - The id of a specific headline (default: nil).
      #
      # Returns an Array of Hashie::Mash.
      def headlines(*args)
        # Build fragments and options
        opts = extract_options!(args)
        opts[:section] ||= 'sports'

        # Build URL
        pattern = "#{opts[:section]}/:sport/:league/news/headlines/:method/:id"
        url = build_url(pattern, opts)

        # Make request
        get(url, opts)
      end

    end
  end
end
