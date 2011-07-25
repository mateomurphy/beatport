module Beatport
  class Feature < Item
    # associated this manually since we don't know the type of the items by default
    attr_reader :items
    
    def initialize(data = {})
      item_klass = Support.constantize(data['type'])

      associate(data, 'items', true, item_klass)
      super
    end
  end
end