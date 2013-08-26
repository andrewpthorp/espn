module ESPN

  # Public: Custom error class for rescuing from all ESPN errors
  class Error < StandardError; end

  # Public: 401 HTTP Status Code
  class Unauthorized < Error; end

  # Public: 404 HTTP Status Code
  class NotFound < Error; end

end
