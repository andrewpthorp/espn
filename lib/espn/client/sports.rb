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
      def sports(options={})
        get("/sports", options)
      end

    end
  end
end
