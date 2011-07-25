module Beatport
  class Track < Item
    has_many :genres, Genre
    has_many :artists, Artist
    has_many :charts, Chart
    has_one :release, Release
    has_one :label, Label
    has_one :price, Price
    has_one :images, Images
    
    # Returns the track with the given id
    def self.find(id)
      Client.retrieve('tracks', Track, :id => id).first
    end
  
    # Returns all the tracks matching the criterea
    def self.all(*args)
      Client.retrieve 'tracks', Track, *args
    end    
    
    def self.most_popular(*args)
      Client.retrieve 'most-popular', Track, *args
    end
    
    def self.most_popular_for_genre(*args)
      Client.retrieve "most-popular/genre", Track, *args    
    end
    
    def self.most_popular_for_artist(*args)
      Client.retrieve "most-popular/artist", Track, *args    
    end

    def self.most_popular_for_label(*args)
      Client.retrieve "most-popular/label", Track, *args    
    end
    
  end
end