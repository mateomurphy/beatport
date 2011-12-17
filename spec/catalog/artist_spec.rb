require 'spec_helper'

module Beatport::Catalog
  describe Artist do
    describe 'structure' do
      before(:all) { @artist = Artist.find(7181) }
      
      it { @artist.id.should == 7181 }
      it { @artist.type.should == "artist" }
      it { @artist.name.should == "Above & Beyond" }
      it { @artist.slug.should == "above-and-beyond" }
      it { @artist.last_publish_date.should == Date.new(2011, 12, 15)}
      it { @artist.biography.should == "" }
      it { @artist.genres.length.should be > 1 }
      it { @artist.sub_genres.length.should be > 1 }            
      it { @artist.top_downloads.length.should be > 1 }
      it { @artist.images.small.url.should == "http://geo-media.beatport.com/items/imageCatalog/0/400000/90000/1000/500/20/491527.jpg" }
      it { @artist.images.medium.url.should == "http://geo-media.beatport.com/items/imageCatalog/0/400000/90000/1000/500/30/491530.jpg" }
      it { @artist.images.large.url.should == "http://geo-media.beatport.com/items/imageCatalog/4000000/600000/80000/6000/400/20/4686424.jpg" }
      it { @artist.featured_releases.length.should be > 1 }
    end
    
    describe '.find' do
      it "should find Above & Beyond when given id 7181" do
        artist = Artist.find(7181)
        artist.id.should == 7181
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