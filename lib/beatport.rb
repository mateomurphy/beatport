# http://api.beatport.com/index.html
require 'ostruct'
require 'httparty'
require 'money'

module Beatport
  autoload :Catalog,         'beatport/catalog'
  autoload :Client,          'beatport/client'
  autoload :Collection,      'beatport/collection'
  autoload :Image,           'beatport/image'
  autoload :Images,          'beatport/images'    
  autoload :Inflector,       'beatport/inflector'
  autoload :Item,            'beatport/item'
  autoload :Parser,          'beatport/parser'
  autoload :Price,           'beatport/price'
  autoload :QueryBuilder,    'beatport/query_builder'
  autoload :Slide,           'beatport/slide'
  autoload :Slideshow,       'beatport/slideshow'
end