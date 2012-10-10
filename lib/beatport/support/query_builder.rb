module Beatport
  module Support
    # Converts a set of arguments into a format that beatport will understand
    class QueryBuilder
      SPECIAL_OPTIONS = ['sortBy', 'facets', 'returnFacets']
      
      def single_result?
        @single_result
      end

      def self.process(*args)
        new.process(*args)
      end

      def special_option?(key)
        SPECIAL_OPTIONS.include?(key)
      end
   
      def process(*args)
        @single_result = false
        
        options = args.last.is_a?(Hash) ? args.pop : {}      
        string_key_type = options.delete(:string_key_type) || :name
        collection = options.delete(:collection)
        key = options.delete(:key) || (args.length > 1 ? args.compact : args.first)
    
        case key
        when Integer
          options[:id] = key
          @single_result = true unless collection
        when String, Symbol
          options[string_key_type] = key.to_s
          @single_result = true unless collection
        when Array
          options[:ids] = key.flatten
        end
      
        options = camelize_keys(options)
      
        options.map do |key, value|
          options[key] = send(Inflector.underscore("process_#{key}"), value) if special_option?(key)
        end
      
        options
      end

      # Camelizes all the keys in the options hash
      def camelize_keys(options)
        Inflector.process_keys(options) { |k| Inflector.camelize(k.to_s, false) }
      end

      # Special processing for sort_by keys
      def process_sort_by(values)
        map_values(values) do |value|
          split_value(value, " ").join(" ")
        end       
      end
    
      # Special processing for facets
      def process_facets(values)
        map_values(values) do |value|
          k, v = split_value(value, ':')
          Array(v).map {|v| "#{k}:#{v}"}.join(',')
        end       
      end
    
      # Special processing for return_facets
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
end