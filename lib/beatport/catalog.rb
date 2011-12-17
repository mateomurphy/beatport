module Beatport
  module Catalog
    autoload :Artist,          'beatport/catalog/artist'
    autoload :Chart,           'beatport/catalog/chart'
    autoload :ChartOverview,   'beatport/catalog/chart_overview'
    autoload :Feature,         'beatport/catalog/feature'    
    autoload :Genre,           'beatport/catalog/genre'
    autoload :Home,            'beatport/catalog/home'
    autoload :Label,           'beatport/catalog/label'
    autoload :List,            'beatport/catalog/list'    
    autoload :Recommendations, 'beatport/catalog/recommendations'
    autoload :Release,         'beatport/catalog/release'
    autoload :Search,          'beatport/catalog/search'
    autoload :Track,           'beatport/catalog/track'  
    
    def self.artist(id)
      Artist.find(id)
    end
  
    def self.artists(*args)
      Artist.all(*args)
    end
  
    def self.chart(id)
      Chart.find(id)
    end
  
    def self.chart_overview(*args)
      ChartOverview.get
    end
  
    def self.charts(*args)
      Chart.all
    end
  
    def self.genre(key)
      Genre.find(key)
    end
  
    def self.genre_overview
      Genre.overview
    end
  
    def self.genres(*args)
      Genre.all(*args)
    end

    def self.home
      Home.get
    end

    def self.label(id)
      Label.find(id)
    end

    def self.labels(*args)
      Label.all(*args)
    end

    def self.release(id)
      Release.find(id)
    end

    def self.releases(*args)
      Release.all(*args)
    end
  
    def self.track(id)
      Track.find(id)
    end
  
    def self.tracks(*args)
      Track.all(*args)
    end    
    
  end
end