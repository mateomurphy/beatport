module Beatport
  module Catalog
    class Slideshow < Item
      attr_accessor :genre_id
    
      has_many :header, Slide
      has_many :feature, Slide
      has_many :small, Slide
    
      def self.find(id = nil)
        obj = Slideshow.new
        obj.genre_id = id
        obj
      end
    
      def header
        @header ||= Slide.header(:genre_id => genre_id)
      end

      def feature
        @feature ||= Slide.feature(:genre_id => genre_id)
      end

      def small
        @small ||= Slide.small(:genre_id => genre_id)
      end
    
    end
  end
end