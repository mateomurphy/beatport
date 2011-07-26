module Beatport
  class Home < Item
    has_one :slideshow, Slideshow
    has_many :features, Feature
    has_many :top_downloads, Track
    
    def self.get
      Client.retrieve 'home', Home
    end
  end
end