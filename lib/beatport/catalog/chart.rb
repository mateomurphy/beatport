module Beatport
  module Catalog  
    class Chart < Item
      has_many :genres, Genre
      has_one :price, Price
      has_many :tracks, Track
      has_one :images, Images
    
      def self.find(id)
        Client.retrieve('charts/detail', Chart, :id => id)
      end
  
      def self.all(*args)
        Client.retrieve 'charts', Chart, *args
      end    
    
      def self.overview
        ChartOverview.get
      end
    
      def self.featured(*args)
        Client.retrieve('featured/charts', Chart, *args)
      end    
    end
  end
end