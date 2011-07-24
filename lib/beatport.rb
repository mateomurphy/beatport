# http://api.beatport.com/index.html
require 'ostruct'
require 'httparty'
require 'money'

module Beatport
  autoload :Artist,        'beatport/artist'
  autoload :Chart,         'beatport/chart'
  autoload :Client,        'beatport/client'
  autoload :Collection,    'beatport/collection'
  autoload :Genre,         'beatport/genre'
  autoload :Image,         'beatport/image'
  autoload :Images,        'beatport/images'    
  autoload :Item,          'beatport/item'
  autoload :Label,         'beatport/label'
  autoload :Release,       'beatport/release'
  autoload :Track,         'beatport/track'  
  autoload :Price,         'beatport/price'
  autoload :ChartOverview, 'beatport/chart_overview'

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
  
  def self.genres(*args)
    Genre.all(*args)
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