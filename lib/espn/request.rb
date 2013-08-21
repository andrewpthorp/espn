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
      options.delete(:sport)
      options.delete(:league)
      options.delete(:team_id)

      response = connection.send(method) do |request|
        request.url(path, options)
        request.options[:timeout] = timeout
        request.options[:open_timeout] = open_timeout
      end

      response.body
    end

  end
end
