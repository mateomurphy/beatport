module Beatport
  module Catalog
    class AccountType < Item
      has_one :images, Images
      
      def self.all
        Client.retrieve 'account-types', AccountType
      end      
    end
  end
end