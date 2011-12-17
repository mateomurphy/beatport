#TODO deprecated in latest api version?
module Beatport
  module Catalog
    class Feature < Item
      # associated this manually since we don't know the type of the items by default
      attr_reader :items
    
      def initialize(data = {})
        item_klass = Inflector.constantize("Beatport::Catalog::#{data['type']}")

        associate(data, 'items', true, item_klass)
        super
      end
    end
  end
end