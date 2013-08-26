require 'faraday'
require 'multi_json'

module Faraday

  # Internal: Faraday Middleware that deals with errors coming back from the API.
  #
  # Examples
  #
  #   conn = Faraday.new({}) do |builder|
  #     builder.use Faraday::Response::RaiseESPNError
  #   end
  class Response::RaiseESPNError < Response::Middleware

    # Internal: Hook into the complete callback for the client. When the result
    # comes back, if it is a status code that we want to raise an error for, we
    # will do that.
    #
    # Raises ESPN::Unauthorized, ESPN::Forbidden and ESPN::Notfound.
    # Returns nothing.
    def on_complete(response)
      case response[:body][:code].to_i
      when 400
        raise ESPN::BadRequest, error_message(response)
      when 401
        raise ESPN::Unauthorized, error_message(response)
      when 403
        raise ESPN::Forbidden, error_message(response)
      when 404
        raise ESPN::NotFound, error_message(response)
      when 500
        raise ESPN::InternalServerError, error_message(response)
      when 504
        raise ESPN::GatewayTimeout, error_message(error)
      end
    end

    # Internal: Parse the response and return a human friendly String
    # representing the error that we received.
    #
    # Returns a String.
    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:body][:status]} - #{response[:body][:message]}"
    end
  end

end
