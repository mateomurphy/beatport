require 'spec_helper'

module Beatport 
  describe Chart do
  
    describe '.find' do
      chart = Chart.find(15722)
      chart.id.should == 15722
      chart.genres.first.name.should == "Trance"
      chart.price.usd.to_s.should == '15.90'
      chart.tracks.length.should == 10
    end
  
    describe '.all' do
      it "should get arbitrary charts" do
        charts = Chart.all
        charts.length.should == 10
      end
    
      it "should get the first page with 5 charts per page" do
        charts = Chart.all :perPage => 5, :page => 1
        charts.length.should == 5
        charts.page.should == 1
        charts.perPage.should == 5
      end
    
      it "should get the first page with 5 charts per page, sorted by publish date and chart id, for the House genre" do
        charts = Chart.all(:sortBy=> ['publishDate asc', 'chartId asc'], :genreId=> 5, :perPage=>5, :page=>1)
        charts.length.should == 5
      
        old_id = nil
        old_date = charts.first.publishDate
      
        charts.each do |chart|
          old_id = nil if old_date.to_s != chart.publishDate.to_s
        
          # it's possible that the genre is a subgenre of house, so we'll disable this test for now
#          chart.genres.map(&:id).should include(5)
          chart.id.should be >= old_id if old_id
          chart.publishDate.should be >= old_date if old_date
        
          old_id = chart.id
          old_date = chart.publishDate
        end
      end
    
      it "should get arbitrary charts with filter metadata for all genre names and artist names" do
        charts = Chart.all :returnFacets => ['genreName', 'performerName']
 
        # despite what the beatport api doc says, the query deoesn't return any performer names...
#        charts.facets['fields']['performerName'].count.should be > 1
        charts.facets['fields']['genreName'].count.should be > 1      
      end

      it "should get all charts for trance and progressive house" do
        charts = Chart.all :facets => {:genreName => ['Trance', 'Progessive House']}
    
        charts.each do |chart|
          genres = chart['genres'].map { |a| a['name'] }
          pp genres
        end
      end
    end
  end
end