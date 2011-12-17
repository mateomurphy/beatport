require 'spec_helper'

module Beatport::Catalog
  describe Artist do
    describe '.find' do
      it "should find Above & Beyond when given id 7181" do
        artist = Artist.find(7181)
        artist.id.should == 7181
        artist.name.should == "Above & Beyond"
        artist.top_downloads.length.should be > 1
        artist.featured_releases.length.should be > 1
      end
    end
  
    describe '.all' do
      it "should get arbitrary artists" do
        artists = Artist.all
        artists.length.should == 10
      end
    
      it "should get the first page with 5 artists per page" do
        artists = Artist.all :per_page => 5, :page => 1
        artists.length.should == 5
        artists.page.should == 1
        artists.per_page.should == 5
      end
    
      it "should get the first page with 5 artists per page, sorted by publish date and artist id, for the House genre" do
        artists = Artist.all(:sort_by=> {:publish_date  => 'asc', :artist_id => 'asc'}, :genre_id=> 5, :per_page=>5, :page=>1)
        artists.length.should == 5
      
        old_id = nil
        old_date = artists.first.last_publish_date
      
        artists.each do |artist|
          old_id = nil if old_date.to_s != artist.last_publish_date.to_s
        
          # beatport has some bad genre data?
          # artist.genres.map(&:id).should include(5)
          artist.id.should be >= old_id if old_id
          artist.last_publish_date.should be >= old_date if old_date
        
          old_id = artist.id
          old_date = artist.publish_date
        end
      end
    
      it "should get arbitrary artists with filter metadata for all genre names and artist names" do
        artists = Artist.all :return_facets => ['genre_name', 'performer_name']
    
        artists.facets['fields']['performer_name'].count.should be > 1
        artists.facets['fields']['genre_name'].count.should be > 1      
      end

      it "should get all trance artists for above & beyond" do
        artists = Artist.all :facets => {:genre_name => ['Trance', 'Progessive House']}
    
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