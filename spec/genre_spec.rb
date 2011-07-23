require 'spec_helper'

describe Beatport do
  
  let :trance do
    Beatport::Genre.new({"slug"=>"trance", "name"=>"Trance", "id"=>7, "subgenres"=>[]}) 
  end
  
  describe '.genre' do
    it "should retrieve information about the trance genre via the slug" do
      genre = Beatport.genre(trance.slug).should
      
      genre.should == trance
    end
    
    it "should retrieve information about the trance genre via its id" do
      genre = Beatport.genre(trance.id)
      genre.should == trance
    end
    
    it "should include subgenre information" do
      genre = Beatport.genre(trance.id)
      genre.subgenres.length.should be > 1
    end
    
    it "should not choke on a non-existant genre" do
      Beatport.genre('fakegenre').should be_nil
    end
  end
  
  describe '.genres' do
    it "should retrieve all genres" do
      genres = Beatport.genres
      genres.length.should > 1
      genres.length.should == genres.count
      genres.length.should == genres.perPage
    end
  
    it "should retrieve genres with their subgenres" do
      genres = Beatport.genres(:subgenres => true)
      genres.first.subgenres.length.should be > 1
    end
  
    it "should retrieve information about the trance genre via the slug" do
      Beatport.genres(trance.slug).should == [trance]
    end
    
    it "should retrieve information about the trance genre via its id" do
      Beatport.genres(trance.id).should == [trance]
    end
  end
end


