module Beatport
  class Release < Item
    has_one :label
    has_many :artists
    has_many :genres
    
    def self.find(id)
      Client.retrieve('releases/detail', Release, :id => id).first
    end

    def self.all(*args)
      Client.retrieve 'releases', Release, *args
    end    
    
  end
end
  