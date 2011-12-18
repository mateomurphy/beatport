module Beatport
  module Catalog
    class Currency < Item
      def self.all
        Client.retrieve 'currencies', Currency
      end
    end
  end
end