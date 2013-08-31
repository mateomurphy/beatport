module Beatport
  module Support
    class Middleware < Faraday::Response::Middleware
      def parse(body)
        body = jsonify(body)
      end
      
      def jsonify(body)
        body = ::JSON.parse(body)
        body = Support::Inflector.process_keys(body) { |k| Support::Inflector.underscore(k) }
      end
    end
  end
end