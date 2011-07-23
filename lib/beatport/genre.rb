module Beatport
  class Genre < Item
    has_many :subgenres, Genre
    
    def self.find(key)
      Client.retrieve('genres', Genre, :key => key, :subgenres => true).first
    end
  
    def self.all(*args)
      Client.retrieve 'genres', Genre, *args
    end
    
  end
end