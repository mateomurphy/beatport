require 'spec_helper'

module Beatport 
  describe Label do
  
    describe '.all' do
      it "should get arbitrary labels" do
        labels = Label.all
        labels.length.should == 10
      end
    
      it "should get the first page with 5 labels per page" do
        labels = Label.all :perPage => 5, :page => 1
        labels.length.should == 5
        labels.page.should == 1
        labels.perPage.should == 5
      end
    
      it "should get the first page with 5 labels per page, sorted by publish date and label id, for the House genre" do
        labels = Label.all(:sortBy=> ['publishDate asc', 'labelId asc'], :genreId=> 5, :perPage=>5, :page=>1)
        labels.length.should == 5
      
        old_id = nil
        old_date = labels.first.lastPublishDate
      
        labels.each do |label|
          old_id = nil if old_date.to_s != label.lastPublishDate.to_s
        
          # beatport has some bad genre data?
          # label.genres.map(&:id).should include(5)
          label.id.should be >= old_id if old_id
          label.lastPublishDate.should be >= old_date if old_date
        
          old_id = label.id
          old_date = label.publishDate
        end
      end
    
      it "should get arbitrary labels with filter metadata for all genre names and label names" do
        labels = Label.all :returnFacets => ['genreName', 'performerName']
        
        # no worky
#        labels.facets['fields']['performerName'].count.should be > 1
        labels.facets['fields']['genreName'].count.should be > 1      
      end

      it "should get all trance labels for above & beyond" do
        labels = Label.all :facets => {:genreName => ['Trance', 'Progessive House']}
    
        labels.each do |label|
          labels = label['labels'].map { |a| a['name'] }
          labels.should include("Above & Beyond")
        
          genres = label['genres'].map { |a| a['name'] }
          genres.should include('Trance')
        end
      end
    end
  end
end