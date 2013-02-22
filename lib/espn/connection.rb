require 'faraday_middleware'
require 'faraday/response/raise_espn_error'

module ESPN
  # @private
  module Connection
    private

    def connection

      options = {
        proxy: proxy,
        ssl: { verify: false },
        url: api_url
      }

      options.merge!(params: { apikey: api_key }) if authed?

      connection = Faraday.new(options) do |builder|
        builder.request :url_encoded

        builder.use Faraday::Response::RaiseESPNError
        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson

        builder.adapter adapter
      end

      connection
    end
  end
end
