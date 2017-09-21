module Beatport
  module Catalog
    class ItemType < Item
      def self.all
        Client.retrieve 'item-types', ItemType
      end
    end
  end
end