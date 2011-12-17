require 'spec_helper'

module Beatport::Catalog
  describe Track do
    describe 'lazy loading' do
      it "should lazy load artists" do
        pending
        track = Track.all(:per_page => 1, :page => 1).first
      end
    end

    describe 'structure' do
      before(:all) { @track = Track.find(1217790) }
      
      it { @track.id.should == 1217790 }
      it { @track.type.should == 'track' }
      it { @track.name.should == "Tonight (IMS Anthem 2009)" }
      it { @track.mix_name.should == "Above & Beyond Remix" }
      it { @track.slug.should == "tonight-ims-anthem-2009-above-and-beyond-remix" }
      it { @track.title.should == "Tonight (IMS Anthem 2009) (Above & Beyond Remix)"}
      it { @track.release_date.should == Date.new(2010,05,17) }
      it { @track.publish_date.should == Date.new(2010,05,17) }
      it { @track.sample_url.should == 'http://geo-samples.beatport.com/items/volumes/volume7/items/1000000/200000/10000/7000/700/90/1217790.LOFI.mp3' }
      it { @track.rtmp_stream_url.should == 'rtmp://geo-rtmp-samples.beatport.com/beatport/_definst_/mp3:lofi_samples/items/volumes/volume7/items/1000000/200000/10000/7000/700/90/1217790.LOFI'}
      it { @track.exclusive.should be_false }
      it { @track.price.to_s.should == "1.49" }
      it { @track.audio_format_fee.wav.to_s.should == "1.00" }
      it { @track.audio_format_fee.aiff.to_s.should == "1.00" }
#      it { @track.current_status.should == nil "General Content" }
      it { @track.length.should == "07:53" }
      it { @track.bpm.should == 128 }
      it { @track.key.standard.letter.should == "D" }
      it { @track.sale_type.should == "purchase" }
      it { @track.artists.map(&:name).should == ["Above & Beyond", "Dirty Vegas"] }
      it { @track.genres.map(&:name).should == ["Trance"]}
      it { @track.sub_genres.map(&:name).should == ['Progressive']}      
      it { @track.charts.should == [] }
      it { @track.release.id.should == 245137 }
      it { @track.label.id.should == 495}
      it { @track.images.small.url.should == 'http://geo-media.beatport.com/items/imageCatalog/0/600000/70000/4000/700/50/674759.jpg' }
      it { @track.images.medium.url.should == 'http://geo-media.beatport.com/items/imageCatalog/0/600000/70000/4000/700/60/674760.jpg' }
      it { @track.images.large.url.should == 'http://geo-media.beatport.com/items/imageCatalog/0/600000/70000/4000/700/60/674761.jpg' }
      it { @track.images.waveform.url.should == 'http://geo-media.beatport.com/items/imageCatalog/1000000/200000/60000/8000/200/20/1268229.png' }                  
    end
    
    describe '.find' do
      it "should find the track with the id 1217790" do
        track = Track.find(1217790)
        track.id.should == 1217790
      end
    end
  
    describe '.all' do
      it "should get arbitrary" do
        Track.all.length.should be > 1
      end
  
      it "should get the first page with 5 tracks per page" do
        tracks = Track.all(:per_page => 5, :page => 1)
        tracks.length.should == 5
        tracks.page.should == 1
        tracks.per_page.should == 5
      end
    
      it "should get the first page with 5 tracks per page, sorted by publish date and release if, for the House genre" do
        tracks = Track.all(:sort_by=> ['publishDate asc', 'releaseId asc'], :genre_id=> 5, :per_page=>5, :page=>1)
        tracks.length.should == 5
      
        old_id = tracks.first.id
        old_date = tracks.first.publish_date
      
        tracks.each do |track|
          track.genres.first.id.should == 5
          track.id.should be >= old_id
          track.publish_date.should be >= old_date
        
          old_id = track.id
          old_date = track.publish_date
        end
      end
    
      it "should get arbitrary tracks with filter metadata for all genre names and artist names" do
        tracks = Track.all :return_facets => ['genre_name', 'performer_name']
    
        tracks.facets['fields']['performer_name'].count.should be > 1
        tracks.facets['fields']['genre_name'].count.should be > 1      
      end

      it "should get all trance tracks for above & beyond" do
        tracks = Track.all :facets => {:genre_name => 'Trance', :performer_name => 'Above & Beyond'}
    
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

