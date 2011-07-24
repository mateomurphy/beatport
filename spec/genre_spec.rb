require 'spec_helper'

module Beatport 
  describe Genre do
    describe '.find' do
      it "should retrieve information about the trance genre via its id" do
        genre = Genre.find(7)
        genre.name.should == "Trance"
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
  end
end

