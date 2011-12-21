require 'spec_helper'

module Beatport::Catalog
  describe Label do

    describe 'structure' do
      subject { Label.find(1390) }
      
      it { should be_a(Label) }
      its (:id) { should == 1390 }
      its (:type) { should == "label" }
      its (:name) { should == "Anjunadeep" }
      its (:slug) { should == "anjunadeep" }      
      its (:source_type) { should == ["store", "mobile", "sushi"] }
      its (:last_publish_date) { should == Date.new(2011, 12, 07) }
      its (:biography) { should == "" }
      its (:'genres.length') { should be > 1 }
      its (:'sub_genres.length') { should be > 0 }      
      its (:display_level) { should == 1 }
      its (:'images.small.url') { should == "http://geo-media.beatport.com/items/imageCatalog/0/0/0/3000/400/0/3406.jpg"}
      its (:'images.medium.url') { should == "http://geo-media.beatport.com/items/imageCatalog/0/0/0/1000/100/90/1191.jpg"}
      its (:'images.banner.url') { should == "http://geo-media.beatport.com/items/imageCatalog/0/300000/40000/5000/100/50/345152.jpg"}            
      its (:'top_downloads.length') { should be > 1 }
      its (:'featured_releases.length') { should be > 1 }
      its (:'most_popular_releases.length') { should be > 1 }
    end
  
    describe '.find' do
      it "should get Anjunadeep give id 1390" do
        label = Label.find(1390)
        label.id.should == 1390
      end
    end
  
    describe '.all' do
      it "should get arbitrary labels" do
        labels = Label.all
        labels.length.should == 10
      end
    
      it "should get the first page with 5 labels per page" do
        labels = Label.all :per_page => 5, :page => 1
        labels.length.should == 5
        labels.page.should == 1
        labels.per_page.should == 5
      end
    
      it "should get the first page with 5 labels per page, sorted by publish date and label id, for the House genre" do
        labels = Label.all(:sort_by=> ['publishDate asc', 'labelId asc'], :genre_id=> 5, :per_page=>5, :page=>1)
        labels.length.should == 5
      
        old_id = nil
        old_date = labels.first.last_publish_date
      
        labels.each do |label|
          old_id = nil if old_date.to_s != label.last_publish_date.to_s
        
          # beatport has some bad genre data?
          # label.genres.map(&:id)) { should include(5)
          label.id.should be >= old_id if old_id
          label.last_publish_date.should be >= old_date if old_date
        
          old_id = label.id
          old_date = label.last_publish_date
        end
      end
    
      it "should get arbitrary labels with filter metadata for all genre names and label names" do
        labels = Label.all :return_facets => ['genre_name', 'performer_name']
        
        # no worky
#        labels.facets['fields']['performer_name'].count) { should be > 1
        labels.facets['fields']['genre_name'].count.should be > 1      
      end

      it "should get all trance labels for above & beyond" do
        labels = Label.all :facets => {:genre_name => ['Trance', 'Progessive House']}
    
        labels.each do |label|
          labels = label['labels'].map { |a| a['name'] }
          labels.should include("Above & Beyond")
        
          genres = label['genres'].map { |a| a['name'] }
          genres.should include('Trance')
        end
      end
    end
    
    describe '.featured' do
      it "should get the featured labels for the Home page" do
        labels = Label.featured
        labels.length.should be > 1
      end
      
      it "should get the featured labels for the Trance page" do
        labels = Label.featured :genre_id => 7
        labels.length.should be > 1
        labels.each do |label|
          label.genres.map(&:id).should include(7)
        end
      end
    end
  end
end