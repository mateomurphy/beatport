require 'spec_helper'

module Beatport::Catalog
  describe "AudioFormat" do
    describe 'structure' do
     before(:all) { @audio_format = AudioFormat.all.first }
     
     it { @audio_format.id.should == 1 }
     it { @audio_format.name.should == "mp3" }
     it { @audio_format.person_preference_visibility.should == true }
    end    
    
  end
end