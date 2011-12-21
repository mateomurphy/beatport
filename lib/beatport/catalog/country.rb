module Beatport
  module Catalog
    class Country < Item
      has_one :currency, Currency
      has_many :states, State
      
      def self.all
        Client.retrieve 'countries', Country
      end
      
      def self.find(code)
        Client.retrieve 'countries', Country, :key => code, :string_key_type => :code_short
      end
    end
  end
end