module Beatport
  class OptionNormalizer
    SPECIAL_OPTIONS = ['sortBy', 'facets', 'returnFacets']
    
    attr_accessor :options
    
    def initialize(options = {})
      # Camelize all the keys in the options hash
      @options = Inflector.process_keys(options) { |k| Inflector.camelize(k.to_s, false) }
    end
   
    def special_option?(key)
      SPECIAL_OPTIONS.include?(key)
    end
  
    # Converts an options hash into a format that beatport will understand
    def process
      options.each do |key, value|
        options[key] = send(Inflector.underscore("process_#{key}"), value) if special_option?(key)
      end
      
      options
    end    
    
    def process_sort_by(values)
      map_values(values) do |value|
        split_value(value, " ").join(" ")
      end       
    end
    
    def process_facets(values)
      map_values(values) do |value|
        k, v = split_value(value, ':')
        v.to_a.map {|v| "#{k}:#{v}"}.join(',')
      end       
    end
    
    def process_return_facets(values)
      map_values(values) do |value|
        Inflector.camelize(value, false)
      end
    end    
    
    def map_values(values)
      values = values.split(/,\s*/) if values.is_a?(String)
      values.map do |value|
        yield value
      end.join(",") 
    end
    
    def split_value(value, seperator)
      value = value.split(seperator) if value.is_a?(String)
        
      [Inflector.camelize(value.first, false), value.last]
    end
    
  end
end