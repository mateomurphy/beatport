module Beatport
  module Catalog
    class Label < Item
      has_many :genres, Genre
      has_many :subgenres, Genre
      has_many :top_downloads, Track
      has_many :featured_releases, Release
      has_many :most_popular_releases, Release
      has_one :images, Images
      
      def self.find(id)
        Client.retrieve('labels/detail', Label, :id => id)
      end

      def self.all(*args)
        Client.retrieve('labels', Label, *args)
      end
    
      def self.featured(*args)
        Client.retrieve('featured/labels', Label, *args)
      end    
    
      def releases(options)
        options[:label_id] = id
        Release.all(options)
      end
    end
  end
end