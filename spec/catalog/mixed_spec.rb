require 'spec_helper'

module Beatport::Catalog
  describe Mixed do
    before :each do
      VCR.insert_cassette 'mixed'
    end

    after :each do
      VCR.eject_cassette
    end

    describe '.all' do
      subject do
        Mixed.all(
          :label_ids => [804,1390],
          :artist_ids => [7181, 10395],
          :chart_ids => [15722, 29514],
          :release_ids => [164808, 385763],
          :track_ids => [1873426,1746687]
        )
      end

      it "should return two of each type" do
        subject.map(&:type).should == ['label', 'label', 'artist', 'artist', 'chart', 'chart', 'release', 'release', 'track', 'track']
      end

      it "should return the right ids" do
        subject.map(&:id).sort.should == [804, 1390, 7181, 10395, 15722, 29514, 164808, 385763, 1746687, 1873426]
      end

    end
  end
end