require 'spec_helper'

module Beatport::Catalog
  describe "AudioFormat" do
    describe 'structure' do
      subject do
        VCR.use_cassette('audio_format_all') { AudioFormat.all.first }
      end
     
      it { should be_an(AudioFormat) }
      its (:id) { should == 1 }
      its (:name) { should == "mp3" }
      its (:person_preference_visibility) { should == true }
    end    
  
    describe '.all' do
      subject do
        VCR.use_cassette('audio_format_all') { AudioFormat.all }
      end
      
      its (:length) { should be > 1 }
    end

    describe '.find' do
      context "by id" do
        subject do
          VCR.use_cassette("audio_format_2") { AudioFormat.find(2) }
        end
        its (:name) { should == "m4a" }
      end
      
      context "by name" do
        subject do
          VCR.use_cassette("audio_format_wav") { AudioFormat.find('wav') }
        end
        its (:name) { should == "wav" }
      end
    end
  end
end