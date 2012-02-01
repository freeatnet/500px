module F00px
  module Response
    class Json < Faraday::Response::Middleware
      def parse(body)
        JSON.parse(body)
      end
    end
  end
end
