module Beatport
  module Catalog
    class Release < Item
      has_many :artists, Artist
      has_one :audio_format_fee, AudioFormatFee
      has_many :genres, Genre
      has_one :images, Images
      has_one :label, Label
      has_one :price, Price
      has_one :recommendations, Recommendations
      has_many :tracks, Track
      has_one :tracks_price, Price

      def discount
        tracks_price - price
      end
    
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
  