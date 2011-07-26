module Beatport
  module Client
    include HTTParty
    base_uri "http://api.beatport.com/catalog"
    format :json
    default_params :v => '1.0', :format => 'json'
    
    def self.retrieve(path, klass, *args)
      result = get("/#{path}", :query => QueryBuilder.process(*args))

      result = Inflector.process_keys(result.parsed_response) { |k| Inflector.underscore(k) }

      case result['results']
      when Array
        Collection.new(klass, result)
      when Hash
        klass.new(result['results'])
      else
        raise "results is an unexpected class #{result['results'].class}"
      end
    end 
  end
end