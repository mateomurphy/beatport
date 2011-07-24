module Beatport
  class Slideshow < Item
    has_many :header, Image
    has_many :small, Image
  end
end