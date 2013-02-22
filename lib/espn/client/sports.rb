module ESPN
  class Client
    module Sports

      # Get all sports supported by the ESPN Developer API
      #
      # @param [Hash] options
      #
      # @return [Hashie::Mash]
      #
      # @example
      #   ESPN.sports()
      def sports(opts={})
        get("/sports", {}, false, false)
      end

    end
  end
end
