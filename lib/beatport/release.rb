module Beatport
  class Release < Item
    has_one :label, Label
    has_many :artists, Artist
    has_many :genres, Genre
    
    def self.find(id)
      Client.retrieve('releases/detail', Release, :id => id)
    end

    def self.all(*args)
      Client.retrieve('releases', Release, *args)
    end    
    
  end
end
  