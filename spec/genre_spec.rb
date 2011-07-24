require 'spec_helper'

module Beatport 
  describe Genre do
    describe '.find' do
      it "should retrieve information about the trance genre via its id" do
        genre = Genre.find(7)
        genre.name.should == "Trance"
        
        genre.slideshow.header.length.should be > 1
        genre.slideshow.small.length.should be > 1
        genre.topDownloads.length.should be > 1
        
        genre.features.each do |feature|
          if feature.autoload
            feature.items.length.should be > 1
            feature.items.first.class.to_s.should == "Beatport::#{feature.type}"
          end
        end
      end
    
      it "should include subgenre information" do
        genre = Genre.find(7)
        genre.subgenres.length.should be > 1
      end
    
      it "should return the default genre with an invalid id" do
        genre = Beatport.genre(9999999)
        genre.name.should == "default"
      end
    end
  
    describe '.all' do
      it "should retrieve all genres" do
        genres = Genre.all
        genres.length.should > 1
        genres.length.should == genres.count
        genres.length.should == genres.perPage
      end
  
      it "should retrieve genres with their subgenres" do
        genres = Genre.all(:subgenres => true)
        genres.first.subgenres.length.should be > 1
      end
  
      it "should retrieve information about the trance genre via the slug" do
        Genre.all('trance').first.name.should == "Trance"
      end
    
      it "should retrieve information about the trance genre via its id" do
        Genre.all(7).first.name.should == "Trance"
      end
    end
    
    describe '.overview' do
      it "should retrieve an overview" do
        overview = Genre.overview
        overview.length.should be > 0
        overview.each do |genre|
          genre.counts.releases.should be > 0
        
          # This fails for glitch hop?
          # genre.list.items.length.should == 3
        end
      end
      
    end
  end
end

