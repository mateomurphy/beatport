require 'spec_helper'

module Beatport 
  describe Artist do
  
    describe '.all' do
      it "should get arbitrary artists" do
        artists = Artist.all
        artists.length.should == 10
      end
    
      it "should get the first page with 5 artists per page" do
        artists = Artist.all :perPage => 5, :page => 1
        artists.length.should == 5
        artists.page.should == 1
        artists.perPage.should == 5
      end
    
      it "should get the first page with 5 artists per page, sorted by publish date and artist id, for the House genre" do
        artists = Artist.all(:sortBy=> ['publishDate asc', 'artistId asc'], :genreId=> 5, :perPage=>5, :page=>1)
        artists.length.should == 5
      
        old_id = nil
        old_date = artists.first.lastPublishDate
      
        artists.each do |artist|
          old_id = nil if old_date.to_s != artist.lastPublishDate.to_s
        
          # beatport has some bad genre data?
          # artist.genres.map(&:id).should include(5)
          artist.id.should be >= old_id if old_id
          artist.lastPublishDate.should be >= old_date if old_date
        
          old_id = artist.id
          old_date = artist.publishDate
        end
      end
    
      it "should get arbitrary artists with filter metadata for all genre names and artist names" do
        artists = Artist.all :returnFacets => ['genreName', 'performerName']
    
        artists.facets['fields']['performerName'].count.should be > 1
        artists.facets['fields']['genreName'].count.should be > 1      
      end

      it "should get all trance artists for above & beyond" do
        artists = Artist.all :facets => {:genreName => ['Trance', 'Progessive House']}
    
        artists.each do |artist|
          artists = artist['artists'].map { |a| a['name'] }
          artists.should include("Above & Beyond")
        
          genres = artist['genres'].map { |a| a['name'] }
          genres.should include('Trance')
        end
      end
    end
  end
end