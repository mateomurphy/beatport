require 'spec_helper'

module Beatport::Catalog
  describe Artist do
    describe 'structure' do
      subject do
        VCR.use_cassette('artist_7181') { Artist.find(7181) }
      end
      
      it { should be_an(Artist) }
      its (:id) { should == 7181 }
      its (:type) { should == "artist" }
      its (:name) { should == "Above & Beyond" }
      its (:slug) { should == "above-and-beyond" }
      its (:last_publish_date) { should >= Date.new(2011, 12, 15)}
      its (:biography) { should == "" }
      its (:'genres.length') { should be > 1 }
      its (:'sub_genres.length') { should be > 1 }
      its (:'top_downloads.length') { VCR.use_cassette('artist_7181_top_downloads') { should be > 1 } }
      its (:'images.small.url') { should == "http://geo-media.beatport.com/image/491527.jpg" }
      its (:'images.medium.url') { should == "http://geo-media.beatport.com/image/491530.jpg" }
      its (:'images.large.url') { should == "http://geo-media.beatport.com/image/4686424.jpg" }
#      its (:'featured_releases.length') { should be > 1 }
    end
    
    describe '.find' do
      context 'with a single id' do
        subject do
          VCR.use_cassette('artist_7181') { Artist.find(7181) }
        end
        
        it { should be_an(Artist) }
        its (:id) { should == 7181 }
      end

      context 'with multiple ids' do
        subject do
          VCR.use_cassette('artist_7181_7182') { Artist.find(7181, 7182) }
        end
        
#        it { should be_a(Collection) }
        its (:length) { should == 2 }
        it "returns the requested artists" do
          subject.map(&:id).should == [7181, 7182]
        end
      end

      context 'with an array of ids' do
        subject do
          VCR.use_cassette('artist_7181_7182') { Artist.find(7181, 7182) }
        end
        
#        it { should be_a(Collection) }
        its (:length) { should == 2 }
        it "returns the requested artists" do
          subject.map(&:id).should == [7181, 7182]
        end
      end
    end    
  
    describe '.all' do
      it "should get arbitrary artists" do
        VCR.use_cassette('artist_all') do
          artists = Artist.all
          artists.length.should == 10
        end
      end
    
      it "should get the first page with 5 artists per page" do
        VCR.use_cassette('artist_all_5_per_page') do
          artists = Artist.all :per_page => 5, :page => 1
          artists.length.should == 5
          artists.page.should == 1
          artists.per_page.should == 5
        end
      end
    
      it "should get the first page with 5 artists per page, sorted by publish date and artist id, for the House genre" do
        VCR.use_cassette('artist_all_sorted') do
          artists = Artist.all(:sort_by=> { :publish_date  => 'asc', :artist_id => 'asc' }, :genre_id=> 5, :per_page=>5, :page=>1)
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
      end
    
      it "should get arbitrary artists with filter metadata for all genre names and artist names" do
        VCR.use_cassette('artist_all_return_facets') do
          artists = Artist.all :return_facets => ['genre_name', 'performer_name']
      
          artists.facets['fields']['performer_name'].count.should be > 1
          artists.facets['fields']['genre_name'].count.should be > 1      
        end
      end

      it "should get all trance artists for above & beyond" do
        pending "Request doesn't return any results"

        VCR.use_cassette('artist_all_for_facets') do
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
end