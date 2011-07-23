require 'spec_helper'

describe Beatport do
  
  describe '.releases' do
    it "should get arbitrary releases" do
      releases = Beatport.releases
      releases.length.should == 10
    end
    
    it "should get the first page with 5 releases per page" do
      releases = Beatport.releases :perPage => 5, :page => 1
      releases.length.should == 5
      releases.page.should == 1
      releases.perPage.should == 5
    end
    
    it "should get the first page with 5 releases per page, sorted by publish date and release id, for the House genre" do
      releases = Beatport.releases(:sortBy=> ['publishDate asc', 'releaseId asc'], :genreId=> 5, :perPage=>5, :page=>1)
      releases.length.should == 5
      
      old_id = nil
      old_date = releases.first.publishDate
      
      releases.each do |release|
        old_id = nil if old_date.to_s != release.publishDate.to_s
        
        release.genres.first.id.should == 5
        release.id.should be >= old_id if old_id
        release.publishDate.should be >= old_date if old_date
        
        old_id = release.id
        old_date = release.publishDate
      end
    end
    
    it "should get arbitrary releases with filter metadata for all genre names and artist names" do
      releases = Beatport.releases :returnFacets => ['genreName', 'performerName']
    
      releases.facets['fields']['performerName'].count.should be > 1
      releases.facets['fields']['genreName'].count.should be > 1      
    end

    it "should get all trance releases for above & beyond" do
      releases = Beatport.releases :facets => {:genreName => 'Trance', :performerName => 'Above & Beyond'}
    
      releases.each do |release|
        artists = release['artists'].map { |a| a['name'] }
        artists.should include("Above & Beyond")
        
        genres = release['genres'].map { |a| a['name'] }
        genres.should include('Trance')
      end
    end
  end
end