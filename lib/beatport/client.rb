module Beatport
  module Client
    include HTTParty
    base_uri "http://api.beatport.com/catalog"
    format :json
    default_params :v => '1.0', :format => 'json'
    
    def self.retrieve(path, klass, *args)
      options = args.last.is_a?(Hash) ? args.pop : {}
    
      key = options.delete(:key) || (args.length > 1 ? args.compact : args.first)
    
      case key
      when Integer
        options[:id] = key
      when String
        options[:slug] = key
      when Array
        options[:ids] = key
      end

      result = get("/#{path}", :query => normalize_options(options))

      case result['results']
      when Array
        Collection.new(klass, result)
      when Hash
        klass.new(result['results'])
      else
        raise "results is an unexpected class #{result['results'].class}"
      end
    end 
  
    def self.normalize_options(options)
      options.each do |key, value|
        case value
        when Array
          options[key] = value.join(',')
        when Hash
          result = []
          value.each do |k, v|
            result << "#{k}:#{v}"
          end
          options[key] = result.join(',')
        end
      end    
    end    
    
  end
end