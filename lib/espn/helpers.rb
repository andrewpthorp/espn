module ESPN
  module Helpers

    # Public: If the last item of the args Array is a Hash, pop it off and
    # return it. If the last item of the args Array is not a Hash, return a new
    # Hash. This works similar to the Rails ActiveSupport #extract_options! but
    # it does not alter the Array class.
    #
    # args - The Array that we want to pop the Hash off of.
    #
    # Returns a Hash.
    def extract_options!(args)
      if args.last.is_a? Hash
        return args.pop
      else
        return {}
      end
    end

  end
end
