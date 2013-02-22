require 'multi_json'

module ESPN
  module Request
    def get(path, options={}, raw=false, include_meta=false)
      request(:get, path, options, raw, include_meta)
    end

    private

    def request(method, path, options, raw, include_meta)
      response = connection(raw).send(method) do |request|
        request.url(path, options)
        request.options[:timeout] = timeout
        request.options[:open_timeout] = open_timeout
      end

      if raw
        response
      else

        if include_meta
          response.body
        else
          response.body.response
        end
      end
    end

  end
end
