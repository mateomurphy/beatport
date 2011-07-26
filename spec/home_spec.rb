require 'spec_helper'

module Beatport 
  describe Home do
    describe '.get' do
      it "should get the home page" do
        home = Home.get
        
        home.slideshow.header.length.should be >= 1
        home.slideshow.feature.length.should be > 1
        home.features.length.should be > 1
        home.top_downloads.length.should be > 1
      end
    end
  end
end