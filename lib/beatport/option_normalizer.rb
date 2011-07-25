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
      process_special(values, ' ')
    end
    
    def process_facets(values)
      process_special(values, ':')
    end
    
    def process_special(values, seperator = ' ')
      values = split_values(values)
      
      values.inject([]) do |result, value|
        k, v = split_value(value, seperator)
        result << v.to_a.map {|v| "#{k}#{seperator}#{v}"}.join(',')
      end.join(",")        
    end
    
    def process_return_facets(values)
      values = split_values(values)
      
      values.map { |v| Inflector.camelize(v, false) }.join(',')
    end    
    
    def split_values(values)
      values = values.split(/,\s*/) if values.is_a?(String)
      values
    end
    
    def split_value(value, seperator)
      value = value.split(seperator) if value.is_a?(String)
        
      [Inflector.camelize(value.first, false), value.last]
    end
    
  end
end