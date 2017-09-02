module Beatport
  module Catalog
    autoload :AccountType,      'beatport/catalog/account_type'
    autoload :Artist,           'beatport/catalog/artist'
    autoload :AudioFormat,      'beatport/catalog/audio_format'
    autoload :AudioFormatFee,   'beatport/catalog/audio_format_fee'
    autoload :Autocomplete,     'beatport/catalog/autocomplete'
    autoload :Chart,            'beatport/catalog/chart'
    autoload :ChartOverview,    'beatport/catalog/chart_overview'
    autoload :Country,          'beatport/catalog/country'
    autoload :Currency,         'beatport/catalog/currency'
    autoload :Djprofile,        'beatport/catalog/djprofile'
    autoload :DynamicImage,     'beatport/catalog/dynamic_image'
    autoload :DynamicImages,    'beatport/catalog/dynamic_images'
    autoload :Feature,          'beatport/catalog/feature'
    autoload :Featured_page,    'beatport/catalog/featured_page'
    autoload :Genre,            'beatport/catalog/genre'
    autoload :Home,             'beatport/catalog/home'
    autoload :ItemType,         'beatport/catalog/item_type'
    autoload :Image,            'beatport/catalog/image'
    autoload :Images,           'beatport/catalog/images'
    autoload :Key,              'beatport/catalog/key'
    autoload :Keys,             'beatport/catalog/keys'
    autoload :Label,            'beatport/catalog/label'
    autoload :List,             'beatport/catalog/list'
    autoload :Mix,              'beatport/catalog/mix'
    autoload :Mixed,            'beatport/catalog/mixed'
    autoload :Part,             'beatport/catalog/part'
    autoload :Pack,             'beatport/catalog/pack'
    autoload :Recommendations,  'beatport/catalog/recommendations'
    autoload :Release,          'beatport/catalog/release'
    autoload :Search,           'beatport/catalog/search'
    autoload :State,            'beatport/catalog/state'
    autoload :Stem,             'beatport/catalog/stem'
    autoload :Stem_pack,         'beatport/catalog/stem_pack'
    autoload :Slide,            'beatport/catalog/slide'
    autoload :Slideshow,        'beatport/catalog/slideshow'
    autoload :SourceType,       'beatport/catalog/source_type'
    autoload :Track,            'beatport/catalog/track'

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
