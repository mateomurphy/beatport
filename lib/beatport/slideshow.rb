module Beatport
  class Slideshow < Item
    has_many :header, Slide
    has_many :small, Slide
  end
end