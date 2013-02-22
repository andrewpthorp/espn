require 'multi_json'

module ESPN
  module Request
    def get(path, options={})
      request(:get, path, options)
    end

    private

    def request(method, path, options)
      response = connection.send(method) do |request|
        request.url(path, options)
        request.options[:timeout] = timeout
        request.options[:open_timeout] = open_timeout
      end
    end

  end
end
