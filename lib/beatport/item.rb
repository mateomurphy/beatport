module Beatport
  
  class Item < OpenStruct
    @@associations = {}
        
    def initialize(data = {})
      raise ArgumentError, "Invalid data passed to Item.new: #{data.inspect}" unless data.is_a?(Hash)
            
      # OpenStruct doesn't like ids in its data, so we store it after the call to super
      id = data.delete('id')
      
      @@associations.each do |k, v|
        associate(data, k, v[:list], v[:klass])
      end
      
      super(data)
      
      @table['id'] = id if id
    end
    
    def id
      @table['id']
    end
    
    # Allow treating the item as a hash
    def [](key)
      send(key) if respond_to?(key)
    end
    
    def associate(data, var, many = false, klass = Item)
      a = data.delete(var.to_s)
      
      return unless a
      
      if many
        a.map! { |g| klass.new(g) }
      elsif a.is_a?(Hash)
        a = klass.new(a)
      elsif a == []
        # In some cases, when there's no data returned for an association it'll be an empty array instead of a hash
        a = nil
      else
        raise ArgumentError, "Invalid data for association: #{a.inspect}"
      end
      
      instance_variable_set(:"@#{var}", a)
      
    end
    
    def self.has_one(var, klass)
      self.send(:attr_reader, var)

      @@associations[var] = {:list => false, :klass => klass}
    end
    
    def self.has_many(var, klass)
      self.send(:attr_reader, var)

      @@associations[var] = {:list => true, :klass => klass}
    end
    
  end
end