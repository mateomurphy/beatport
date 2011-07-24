module Beatport
  class Genre < Item
    has_many :subgenres, Genre
    has_many :topDownloads, Track
    
    def self.find(id)
      Client.retrieve('genres/detail', Genre, :id => id)
    end
  
    def self.all(*args)
      Client.retrieve('genres', Genre, *args)
    end
    
  end
end