require 'spec_helper'

module Beatport 
  describe Genre do
    let :trance do
      Genre.new({"slug"=>"trance", "name"=>"Trance", "id"=>7, "subgenres"=>[]}) 
    end
  
    describe '.find' do
      it "should retrieve information about the trance genre via the slug" do
        genre = Genre.find(trance.slug).should
      
        genre.should == trance
      end
    
      it "should retrieve information about the trance genre via its id" do
        genre = Genre.find(trance.id)
        genre.should == trance
      end
    
      it "should include subgenre information" do
        genre = Genre.find(trance.id)
        genre.subgenres.length.should be > 1
      end
    
      it "should not choke on a non-existant genre" do
        Beatport.genre('fakegenre').should be_nil
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
        Genre.all(trance.slug).should == [trance]
      end
    
      it "should retrieve information about the trance genre via its id" do
        Genre.all(trance.id).should == [trance]
      end
    end
  end
end

