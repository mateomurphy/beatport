require 'spec_helper'

module Beatport 
  describe Track do
    describe '.find' do
      it "should find the track with the id 1217790" do
        track = Track.find(1217790)
        track.id.should == 1217790
        track.name.should == "Tonight (IMS Anthem 2009)"
      end
    end
  
    describe '.all' do
      it "should retrieve arbitrary" do
        Track.all.length.should be > 1
      end
  
      it "should get the first page with 5 tracks per page" do
        tracks = Track.all(:perPage => 5, :page => 1)
        tracks.length.should == 5
        tracks.page.should == 1
        tracks.perPage.should == 5
      end
    
      it "should get the first page with 5 tracks per page, sorted by publish date and release if, for the House genre" do
        tracks = Track.all(:sortBy=> ['publishDate asc', 'releaseId asc'], :genreId=> 5, :perPage=>5, :page=>1)
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
        tracks = Track.all :returnFacets => ['genreName', 'performerName']
    
        tracks.facets['fields']['performerName'].count.should be > 1
        tracks.facets['fields']['genreName'].count.should be > 1      
      end

      it "should get all trance tracks for above & beyond" do
        tracks = Track.all :facets => {:genreName => 'Trance', :performerName => 'Above & Beyond'}
    
        tracks.each do |track|
          artists = track['artists'].map { |a| a['name'] }
          artists.should include("Above & Beyond")
        
          genres = track['genres'].map { |a| a['name'] }
          genres.should include('Trance')
        end
      end
    end

    describe '.most_popular' do
      it "should get the top download for the home page" do
        tracks = Track.most_popular
        tracks.count.should == 100
        tracks.length.should == 10
      end
      
      it "should get the top classics for the home page" do
        tracks = Track.most_popular :status => 5
        tracks.count.should == 100
        tracks.length.should == 10
      end

      it "should not return the same results for most_popular and classics" do
        popular = Track.most_popular
        classics = Track.most_popular :status => 5
        
        popular.map(&:id).should_not == classics.map(&:id)
      end
    end
    
    describe '.most_popular_for_genre' do
      it "should get the top download for the trance page" do
        tracks = Track.most_popular_for_genre 7
        
        tracks.count.should == 100
        tracks.length.should == 10
        tracks.each do |track|
          track.genres.map(&:id).should include(7)
        end
      end

      it "should get the top classics for the trance page" do
        tracks = Track.most_popular_for_genre 7, :status => 5
        
        tracks.each do |track|
          track.genres.map(&:id).should include(7)
        end
      end
      
      it "should not return the same results for most_popular and classics" do
        popular = Track.most_popular_for_genre 7
        classics = Track.most_popular_for_genre 7, :status => 5
        
        popular.map(&:id).should_not == classics.map(&:id)
      end      
      
    end

    describe '.most_popular_for_artist' do
      it "should get the top downloads for Above & Beyond" do
        tracks = Track.most_popular_for_artist 7181
        tracks.length.should be > 1
        tracks.each do |track|
          track.artists.map(&:id).should include(7181)
        end
      end
    end

    describe '.most_popular_for_label' do
      it "should get the top downloads for Anjunabeats" do
        tracks = Track.most_popular_for_label 804
        tracks.length.should be > 1
        tracks.each do |track|
          track.label.id.should == 804
        end
      end      
    end
  end
end

