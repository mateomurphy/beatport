# http://api.beatport.com/index.html
require 'ostruct'
require 'httparty'
require 'money'

module Beatport
  autoload :Catalog,         'beatport/catalog'
  autoload :Client,          'beatport/client'
  autoload :Collection,      'beatport/collection'
  autoload :Item,            'beatport/item'
  autoload :Price,           'beatport/price'
  autoload :Support,         'beatport/support'
end