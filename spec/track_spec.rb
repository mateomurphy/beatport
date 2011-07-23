require 'spec_helper'

describe Beatport do
  
  describe '.track' do
    it "should find the track with the id 1217790" do
      track = Beatport.track(1217790)
      track.id.should == 1217790
      track.name.should == "Tonight (IMS Anthem 2009)"
    end
  end
  
  describe '.tracks' do
    it "should retrieve arbitrary" do
      Beatport.tracks.length.should be > 1
    end
  
    it "should get the first page with 5 tracks per page" do
      tracks = Beatport.tracks(:perPage => 5, :page => 1)
      tracks.length.should == 5
      tracks.page.should == 1
      tracks.perPage.should == 5
    end
    
    it "should get the first page with 5 tracks per page, sorted by publish date and release if, for the House genre" do
      tracks = Beatport.tracks(:sortBy=> ['publishDate asc', 'releaseId asc'], :genreId=> 5, :perPage=>5, :page=>1)
      tracks.length.should == 5
      
      old_id = tracks.first.id
      old_date = tracks.first.publishDate
      
      tracks.each do |track|
        track.genres.first.id.should == 5
        track.id.should be >= old_id
        track.publishDate.should be >= old_date
        
        old_id = track.id
        old_date = track.publishDate
      end
    end
    
    it "should get arbitrary tracks with filter metadata for all genre names and artist names" do
      tracks = Beatport.tracks :returnFacets => ['genreName', 'performerName']
    
      tracks.facets['fields']['performerName'].count.should be > 1
      tracks.facets['fields']['genreName'].count.should be > 1      
    end

    it "should get all trance tracks for above & beyond" do
      tracks = Beatport.tracks :facets => {:genreName => 'Trance', :performerName => 'Above & Beyond'}
    
      tracks.each do |track|
        artists = track['artists'].map { |a| a['name'] }
        artists.should include("Above & Beyond")
        
        genres = track['genres'].map { |a| a['name'] }
        genres.should include('Trance')
      end
    end
  end
end


