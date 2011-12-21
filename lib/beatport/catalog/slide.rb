module Beatport
  module Catalog
    class Slide < Item
      def self.header(*args)
        Client.retrieve 'slideshows/header', Slide, *args
      end
    
      def self.feature(*args)
        Client.retrieve 'slideshows/feature', Slide, *args
      end

      def self.small(*args)
        Client.retrieve 'slideshows/small', Slide, *args
      end
    end
  end
end