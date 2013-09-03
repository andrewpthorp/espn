module ESPN

  # Public: Commonly used Helpers are defined in this module.
  #
  # Examples
  #
  #   class Client
  #     include ESPN::Helpers
  #   end
  module Helpers

    # Public: Determine if a given Object is blank? If it is a String, or anything
    # that responds to :empty?, it will use that method. If it does not respond to
    # :empty? it will check that the Object is not nil.
    #
    # object  - The Object to check for blank.
    #
    # Examples
    #
    #   blank?('')
    #   # => true
    #
    #   blank?('foo')
    #   # => false
    #
    #   blank?(nil)
    #   # => true
    #
    #   blank?(Object.new)
    #   # => false
    #
    # Returns a Boolean.
    def blank?(object)
      object.respond_to?(:empty?) ? object.empty? : !object
    end

  end

end
