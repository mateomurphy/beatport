module Beatport
  module Catalog
    class SourceType < Item
      def self.all
        Client.retrieve 'source-types', SourceType
      end      
    end
  end
end