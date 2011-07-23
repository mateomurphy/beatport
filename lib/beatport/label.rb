module Beatport
  class Label < Item
    has_many :genres
    has_many :subgenres
    
    def self.find(id)
      Client.retrieve('labels/detail', Label, :id => id).first
    end

    def self.all(*args)
      Client.retrieve 'labels', Label, *args
    end
    
  end
  
end