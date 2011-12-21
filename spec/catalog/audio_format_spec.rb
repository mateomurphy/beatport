require 'spec_helper'

module Beatport::Catalog
  describe "AudioFormat" do
    describe 'structure' do
      subject { AudioFormat.all.first }
     
      it { should be_an(AudioFormat) }
      its (:id) { should == 1 }
      its (:name) { should == "mp3" }
      its (:person_preference_visibility) { should == true }
    end    
  
    describe '.all' do
      subject { AudioFormat.all }
      
      its (:length) { should be > 1 }
    end

    describe '.find' do
      context "by id" do
        subject { AudioFormat.find(2) }
        its (:name) { should == "m4a" }
      end
      
      context "by name" do
        subject { AudioFormat.find('wav') }
        its (:name) { should == "wav" }
      end
    end
  end
end