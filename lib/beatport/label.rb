module Beatport
  class Label < Item
    has_many :genres, Genre
    has_many :subgenres, Genre
    
    def self.find(id)
      Client.retrieve('labels/detail', Label, :id => id)
    end

    def self.all(*args)
      Client.retrieve 'labels', Label, *args
    end
    
  end
  
end