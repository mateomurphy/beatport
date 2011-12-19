module Beatport
  module Catalog
    class Genre < Item
      has_many :subgenres, Genre
#      has_many :top_downloads, Track
#      has_one :slideshow, Slideshow
#      has_many :features, Feature
      has_one :counts, Item
      has_one :list, List
    
      # Returns the genre with the given id or slug
      def self.find(key)
        Client.retrieve('genres', Genre, :key => key, :string_key_type => :slug, :subgenres => true).first
      end
  
      # Returns all the genres
      def self.all(options = {})
        Client.retrieve('genres', Genre, options)
      end
    
      def self.overview
        Client.retrieve('genres/overview', Genre)
      end
      
      # Returns the top downloads for the genre
      def top_downloads
        @top_downloads ||= Track.most_popular_for_genre(id)
      end
    
      # Returns the slideshow for the genre
      def slideshow
        @slideshow ||= Slideshow.find(id)
      end
    end
  end
end