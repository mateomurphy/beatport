module Beatport
  module Client
    include HTTParty
    parser Beatport::Parser
    base_uri "http://api.beatport.com/catalog/3"
    format :json
#    default_params :v => '1.0', :format => 'json'
    
    def self.retrieve(path, klass, *args)
      result = get("/#{path}", :query => QueryBuilder.process(*args))

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