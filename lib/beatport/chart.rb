module Beatport
  class Chart < Item
    has_many :genres, Genre
    
    
    def self.find(id)
      Client.retrieve('charts/detail', Chart, :id => id)
    end
  
    #  def self.overview(*args)
  #    Client.retrieve 'charts/overview', Chart, *args
  #  end
  
    def self.all(*args)
      Client.retrieve 'charts', Chart, *args
    end    
    
  end
end