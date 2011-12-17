module Beatport
  module Catalog
    class Release < Item
      has_one :label, Label
      has_many :artists, Artist
      has_many :genres, Genre
      has_one :price, Price
      has_one :discount, Price
      has_one :track_price, Price
      has_one :images, Images
      has_one :recommendations, Recommendations
      has_many :tracks, Track
    
      def self.find(id)
        Client.retrieve('releases/detail', Release, :id => id)
      end

      def self.all(*args)
        Client.retrieve('releases', Release, *args)
      end    
    
      def self.featured(*args)
        Client.retrieve('featured/releases', Release, *args)
      end
    end
  end
end
  