module Beatport
  module Catalog
    class Country < Item
      has_one :currency, Currency
      has_many :states, State
      
      def self.all
        Client.retrieve 'countries', Country
      end
      
      def self.find(code)
        Client.retrieve('countries', Country, :code_short => code).first
      end
    end
  end
end