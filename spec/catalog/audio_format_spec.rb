require 'spec_helper'

module Beatport::Catalog
  describe "AudioFormat" do
    describe 'structure' do
      subject { AudioFormat.all.first }
     
      specify { subject.id.should == 1 }
      specify { subject.name.should == "mp3" }
      specify { subject.person_preference_visibility.should == true }
    end    
    
  end
end