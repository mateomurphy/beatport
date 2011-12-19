require 'spec_helper'

module Beatport::Catalog
  describe "AudioFormat" do
    describe 'structure' do
      subject { AudioFormat.all.first }
     
      its (:id) { should == 1 }
      its (:name) { should == "mp3" }
      its (:person_preference_visibility) { should == true }
    end    
    
  end
end