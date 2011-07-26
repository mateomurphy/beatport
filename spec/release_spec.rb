require 'spec_helper'

module Beatport 
  describe Release do
  
    describe '.find' do
      it "should get Anjunabeats Volume 6 when given id 164808" do
        release = Release.find(164808)
        release.id.should == 164808
        release.name.should == "Anjunabeats Volume 6 (Unmixed - DJ Ready)"
        release.track_price.usd.to_s.should == "43.21"
        release.artists.map(&:name).should include("Paul Keeley")
        release.images.small.width.should == 30
        release.recommendations.releases.length.should be > 1
      end
    end
  
    describe '.all' do
      it "should get arbitrary releases" do
        releases = Release.all
        releases.length.should == 10
      end
    
      it "should get the first page with 5 releases per page" do
        releases = Release.all :per_page => 5, :page => 1
        releases.length.should == 5
        releases.page.should == 1
        releases.per_page.should == 5
      end
    
      it "should get the first page with 5 releases per page, sorted by publish date and release id, for the House genre" do
        releases = Release.all(:sort_by=> ['publishDate asc', 'releaseId asc'], :genre_id=> 5, :per_page=>5, :page=>1)
        releases.length.should == 5
      
        old_id = nil
        old_date = releases.first.publish_date
      
        releases.each do |release|
          old_id = nil if old_date.to_s != release.publish_date.to_s
        
          release.genres.first.id.should == 5
          release.id.should be >= old_id if old_id
          release.publish_date.should be >= old_date if old_date
        
          old_id = release.id
          old_date = release.publish_date
        end
      end
    
      it "should get arbitrary releases with filter metadata for all genre names and artist names" do
        releases = Release.all :return_facets => ['genre_name', 'performer_name']
    
        releases.facets['fields']['performer_name'].count.should be > 1
        releases.facets['fields']['genre_name'].count.should be > 1      
      end

      it "should get all trance releases for above & beyond" do
        releases = Release.all :facets => {:genre_name => 'Trance', :performer_name => 'Above & Beyond'}
    
        releases.each do |release|
          artists = release['artists'].map { |a| a['name'] }
          artists.should include("Above & Beyond")
        
          genres = release['genres'].map { |a| a['name'] }
          genres.should include('Trance')
        end
      end
    end

    describe '.featured' do
      it "should get the featured releases for the Home page" do
        releases = Release.featured
        releases.length.should be > 1
      end
      
      it "should get the featured releases for the Trance page" do
        releases = Release.featured :genre_id => 7
        releases.length.should be > 1
        releases.each do |release|
          release.genres.map(&:id).should include(7)
        end  
      end
      
      it "should get 'Just Added' featured releases for the Trance page" do
        releases = Release.featured :genre_id => 7, :just_added => true
        releases.length.should be > 1
        releases.each do |release|
          release.genres.map(&:id).should include(7)
        end  
      end
      
      it "should not give the same releases with justAdded true and false" do
        featured = Release.featured :genre_id => 7
        just_added = Release.featured :genre_id => 7, :just_added => true
        
        featured.map(&:id).should_not == just_added.map(&:id)
      end
    end
  end
end