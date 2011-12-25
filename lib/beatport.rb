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
  
  def self.const_missing(name)
    if Beatport::Catalog.const_defined?(name)
      $stderr << "Beatport::#{name} has moved to Beatport::Catalog::#{name}, please ajust your code accordingly"
      Beatport::Catalog.const_get(name)
    else
      super
    end
  end
end