module Beatport
  module Catalog
    class Genre < Item
      has_many :subgenres, Genre
      has_many :top_downloads, Track
      has_one :slideshow, Slideshow
      has_many :features, Feature
      has_one :counts, Item
      has_one :list, List
    
      def self.find(id)
        Client.retrieve('genres/detail', Genre, :id => id)
      end
  
      def self.all(*args)
        Client.retrieve('genres', Genre, *args)
      end
    
      def self.overview
        Client.retrieve('genres/overview', Genre)
      end
    
      def top_downloads
        @top_downloads ||= Track.most_popular_for_genre(id)
      end
    
      def slideshow
        @slideshow ||= Slideshow.find(id)
      end
    end
  end
end