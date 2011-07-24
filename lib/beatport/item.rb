require 'ostruct'

module Beatport
  
  class Item < OpenStruct
    @@associations = {}
        
    def initialize(data = {})
      raise ArgumentError, "Invalid data passed to Item.new" unless data.is_a?(Hash)
            
      # OpenStruct doesn't like ids in its data, so we store it after the call to super
      id = data.delete('id')
      
      @@associations.each do |k, v|
        associate(data, k, v[:list], v[:klass])
      end
      
      super(data)
      
      @table['id'] = id
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
        instance_variable_set(:"@#{var}", a.map { |g| klass.new(g) })
      else
        instance_variable_set(:"@#{var}", klass.new(a))
      end
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