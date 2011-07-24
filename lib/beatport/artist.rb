module Beatport
  class Artist < Item
    has_many :genres, Genre
    has_many :subgenres, Genre
    
    def self.find(id)
      Client.retrieve('artists/detail', Artist, :id => id)
    end

    def self.all(*args)
      Client.retrieve 'artists', Artist, *args
    end
    
  end
end