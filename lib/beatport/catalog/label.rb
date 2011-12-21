module Beatport
  module Catalog
    class Label < Item
      has_many :genres, Genre
      has_many :subgenres, Genre
      has_many :top_downloads, Track
      has_many :featured_releases, Release
      has_many :most_popular_releases, Release
      has_one :images, Images
      
      def self.find(*args)
        Client.retrieve 'labels', Label, *args
      end

      def self.all(options = {})
        Client.retrieve 'labels', Label, options
      end
    
      def self.featured(*args)
        Client.retrieve 'featured/labels', Label, *args
      end    
    
      def releases(options)
        options[:label_id] = id
        Release.all(options)
      end
    end
  end
end