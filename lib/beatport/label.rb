module Beatport
  class Label < Item
    has_many :genres, Genre
    has_many :subgenres, Genre
    has_many :top_downloads, Track
    has_many :featured_releases, Release
    has_many :most_popular_releases, Release
    
    def self.find(id)
      Client.retrieve('labels/detail', Label, :id => id)
    end

    def self.all(*args)
      Client.retrieve('labels', Label, *args)
    end
    
    def self.featured(*args)
      Client.retrieve('featured/labels', Label, *args)
    end    
  end
end