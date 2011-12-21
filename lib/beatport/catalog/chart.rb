module Beatport
  module Catalog  
    class Chart < Item
      has_one :audio_format_fee, AudioFormatFee      
      has_many :genres, Genre
      has_one :images, Images
      has_one :price, Price
      has_many :tracks, Track
    
      def self.find(*keys)
        Client.retrieve 'charts', Chart, *keys
      end
  
      def self.all(options = {})
        Client.retrieve 'charts', Chart, options
      end    
    
      def self.overview
        ChartOverview.get
      end
    
      def self.featured(*args)
        Client.retrieve 'featured/charts', Chart, *args
      end
      
      def tracks(options = {})
        options[:chart_id] = id
        @tracks ||= Track.all(options)
      end
      
    end
  end
end