module Beatport
  module Catalog
    class AccountType < Item
      has_one :images, Images
      
      # Returns the account type with the name given
      def self.find(key)
        Client.retrieve('account-types', AccountType, :key => key).first
      end
      
      # Returns all the account types
      def self.all
        Client.retrieve 'account-types', AccountType
      end
    end
  end
end