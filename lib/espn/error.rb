module ESPN

  # Public: Custom error class for rescuing from all ESPN errors
  class Error < StandardError; end

  # Public: 400 HTTP Status Code
  class BadRequest < Error; end

  # Public: 401 HTTP Status Code
  class Unauthorized < Error; end

  # Public: 403 HTTP Status Code
  class Forbidden < Error; end

  # Public: 404 HTTP Status Code
  class NotFound < Error; end

  # Public: 500 HTTP Status Code
  class InternalServerError < Error; end

  # Public: 504 HTTP Status Code
  class GatewayTimeout < Error; end

end
