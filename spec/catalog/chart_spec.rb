# encoding: UTF-8

require 'spec_helper'

module Beatport::Catalog
  describe Chart do
    before :each do
      VCR.insert_cassette 'chart'
    end

    after :each do
      VCR.eject_cassette
    end

    describe 'structure' do
      subject { Chart.find(15722) }
      
      it { should be_a(Chart) }
      its (:id) { should == 15722 }
      its (:type) { should == "chart" }
      its (:name) { should == "Nitrous Oxide – April Top 10" }    
      its (:slug) { should == "nitrous-oxide-april-top-10" }
      its (:description) { should == "" }
      its (:publish_date) { should == Date.new(2009, 05, 12) }
      its (:'price.to_s') { should == '13.91' }
      its (:'audio_format_fee.wav.to_s') { should == "9.00" }
      its (:'audio_format_fee.aiff.to_s') { should == "9.00" }      
      specify { subject.genres.map(&:name).should == ["Trance"] }
      its (:'images.small.url') { should == "http://geo-media.beatport.com/image/491534.jpg"}
      its (:'images.medium.url') { should == "http://geo-media.beatport.com/image/412921.jpg"}
      its (:'images.large.url') { should == "http://geo-media.beatport.com/image/412922.jpg"}            
      its (:'tracks.length') { should == 9 }
    end
  
    describe '.find' do
      context 'with a single id' do
        subject { Chart.find(15722) }

        its (:id) { should == 15722 }
      end

      context 'with multiple ids' do
        subject { Chart.find(15722, 15723) }
        its (:length) { should == 2 }
        it "returns the requested charts" do
          subject.map(&:id).should == [15722, 15723]
        end
      end

      context 'with an array of ids' do
        subject { Chart.find([15722, 15723]) }
        its (:length) { should == 2 }
        it "returns the requested charts" do
          subject.map(&:id).should == [15722, 15723]
        end
      end
    end
  
    describe '.all' do
      it "should get arbitrary charts" do
        charts = Chart.all
        charts.length.should == 10
      end
    
      it "should get the first page with 5 charts per page" do
        charts = Chart.all :per_page => 5, :page => 1
        charts.length.should == 5
        charts.page.should == 1
        charts.per_page.should == 5
      end
    
      it "should get the first page with 5 charts per page, sorted by publish date and chart id, for the House genre" do
        charts = Chart.all(:sort_by=> ['publishDate asc', 'chartId asc'], :genre_id=> 5, :per_page=>5, :page=>1)
        charts.length.should == 5
      
        old_id = nil
        old_date = charts.first.publish_date
      
        charts.each do |chart|
          old_id = nil if old_date.to_s != chart.publish_date.to_s
        
          # it's possible that the genre is a subgenre of house, so we'll disable this test for now
#          chart.genres.map(&:id).should include(5)
          chart.id.should be >= old_id if old_id
          chart.publish_date.should be >= old_date if old_date
        
          old_id = chart.id
          old_date = chart.publish_date
        end
      end
    
      it "should get arbitrary charts with filter metadata for all genre names and artist names" do
        charts = Chart.all :return_facets => ['genre_name', 'performer_name']
 
        # despite what the beatport api doc says, the query deoesn't return any performer names...
#        charts.facets['fields']['performer_name'].count.should be > 1
        charts.facets['fields']['genre_name'].count.should be > 1      
      end

      it "should get all charts for trance and progressive house" do
        charts = Chart.all :facets => {:genre_name => ['Trance', 'Progessive House']}
    
        charts.each do |chart|
          genres = chart['genres'].map { |a| a['name'] }
          pp genres
        end
      end
    end
    
    describe '.featured' do
      it "should get the featured charts for the Home page" do
        charts = Chart.featured
        charts.length.should be > 1
      end
      
      it "should get the featured charts for the Trance page" do
        charts = Chart.featured :genre_id => 7
        charts.length.should be > 1
        charts.each do |chart|
          chart.genres.map(&:id).should include(7)
        end
      end
    end
  end
end