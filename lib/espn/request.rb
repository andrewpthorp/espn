require 'multi_json'

module ESPN
  module Request
    def get(path, options={})
      request(:get, path, options)
    end

    private

    def request(method, path, options)

      # TODO: Decide if I want to delete these or not. There is probably
      # a better way to do this, if so, by filtering them out.
      %w( sport league method section team_id headline_id category_id clip_id
          athlete_id event_id note_id podcast_id recording_id ).each do |k|
        options.delete(k.to_sym)
      end

      response = connection.send(method) do |request|
        request.url(path, options)
        request.options[:timeout] = timeout
        request.options[:open_timeout] = open_timeout
      end

      response.body
    end

  end
end
