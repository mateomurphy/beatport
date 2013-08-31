module Beatport
  module Client
    include HTTParty
    parser Beatport::Support::Parser
    base_uri "http://api.beatport.com/catalog/3"
    format :json
#    default_params :v => '1.0', :format => 'json'
    
    def self.retrieve(path, klass, *args)
      builder = Support::QueryBuilder.new
      
      result = get("/#{path}", :query => builder.process(*args))

      if result['metadata']['error']
        raise Error.new("#{result['metadata']['error']}: #{result['metadata']['message']}")
      end

      case result['results']
      when Array
        if builder.single_result?
          klass.new(result['results'].first) if result['results'].any?
        else
          Collection.new(klass, result)
        end
      when Hash
        klass.new(result['results'])
      else
        raise Error.new("results is an unexpected class #{result['results'].class}")
      end
    end 
  end
end