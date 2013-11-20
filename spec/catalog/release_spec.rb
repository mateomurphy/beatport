require 'spec_helper'

module Beatport::Catalog
  describe Release do
    before :each do
      VCR.insert_cassette 'release'
    end

    after :each do
      VCR.eject_cassette
    end

    describe 'structure' do
      subject { Release.find(164808) }

      it { should be_a(Release) }
      its (:id) { should == 164808 }
      its (:type) { should == 'release' }
      its (:name) { should == "Anjunabeats Volume 6 (Unmixed - DJ Ready)" }
      its (:slug) { should == 'anjunabeats-volume-6-unmixed-dj-ready'}
      its (:release_date) { should == Date.new(2009, 04, 06) }
      its (:publish_date) { should == Date.new(2009, 04, 06) }
      its (:exclusive) { should == false }
      its (:category) { should == 'Album' }
      its (:current_status) { should == "General Content"}
      its (:catalog_number) { should == "ANJCDCO011D"}
      its (:purchasable) { should == true }
      its (:'price.to_s') { should == "9.99" }
      its (:'tracks_price.to_s') { should == "43.21" }
      its (:'audio_format_fee.wav.to_s') { should == '21.75'}
      its (:'audio_format_fee.aiff.to_s') { should == '21.75'}
      its (:'label.id') { should == 804 }
      specify { subject.artists.map(&:name).should include("Paul Keeley") }
      specify { subject.genres.map(&:name).sort.should == ["Progressive House", "Trance"] }
      its (:'images.small.url') { should == "http://geo-media.beatport.com/image/392699.jpg" }
      its (:'images.medium.url') { should == "http://geo-media.beatport.com/image/392700.jpg" }
      its (:'images.large.url') { should == "http://geo-media.beatport.com/image/392701.jpg" }
      its (:'discount.to_s') { should == "33.22" }
#      its (:'recommendations.releases.length') { should > 1 }
    end

    describe '.find' do
      it "should get Anjunabeats Volume 6 when given id 164808" do
        release = Release.find(164808)
        release.id.should == 164808
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
        pending "test will not give consistent results, revisit"

        featured = Release.featured :genre_id => 7
        just_added = Release.featured :genre_id => 7, :just_added => true

        featured.map(&:id).should_not == just_added.map(&:id)
      end
    end

    describe '#tracks' do
      subject :all do
        release = Release.find(164808)
        release.tracks
      end

      it "should return all 29 tracks for Anjunabeats Volume 6" do
        subject.count.should == 29
      end

      it "should return paper jet as the first track" do
        subject.first.name.should == "Paper Jet"
      end

    end
  end
end
