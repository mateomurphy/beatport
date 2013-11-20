module Beatport

  class Item < OpenStruct
    class << self
      def associations
        @associations ||= {}
      end

      def has_one(var, klass)
        lazy_accessor(var)
        self.associations[var] = {:list => false, :klass => klass}
      end

      def has_many(var, klass)
        lazy_accessor(var)
        self.associations[var] = {:list => true, :klass => klass}
      end

      def lazy_accessor(var)
        return if respond_to?(var)
        class_eval "def #{var}; @#{var}; end"
      end

      def find_by_name(name, *args)
        raise "finding by name is not supported" unless respond_to?(:name_facet)

        options = args.last || {}
        options[:facets] ||= {}
        options[:facets][name_facet] = name
        results = find(options)

        case results.length
        when 0
          nil
        when 1
          results.first
        else
          raise "find_by_name returned multiple results"
        end
      end
    end

    def initialize(data = {})
      raise ArgumentError, "Invalid data passed to Item.new: #{data.inspect}" unless data.is_a?(Hash)

      # OpenStruct doesn't like id or type, so we store them after the call to super
      id = data.delete('id')
      type = data.delete('type')

      self.class.associations.each do |k, v|
        associate(data, k, v[:list], v[:klass])
      end

      super(data)

      data.each do |k, v|
        @table[k.to_sym] = Date.parse(v) if k =~ /_date$/
        @table[k.to_sym] = Regexp.new(v.to_s) if k =~ /_regex$/
      end

      @table['id'] = id if id
      @table['type'] = type if type
    end

    def id
      @table['id']
    end

    def type
      @table['type']
    end

    # Allow treating the item as a hash
    def [](key)
      send(key) if respond_to?(key)
    end

    def associate(data, var, collection = false, klass = Item)
      a = data.delete(var.to_s)

      return unless a

      if collection && a.is_a?(Array)
        a = a.compact.map { |g| klass.new(g) }
      elsif !collection && a.is_a?(Hash)
        a = klass.new(a)
      elsif a == [] # || !a
        # In some cases, when there's no data returned for an association it'll be an empty array instead of a hash
        a = nil
      else
        raise ArgumentError, "Invalid data for association: '#{var}' = #{a.inspect}"
      end

      instance_variable_set(:"@#{var}", a)
    end


  end
end
