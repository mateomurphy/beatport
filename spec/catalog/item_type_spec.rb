require 'spec_helper'

module Beatport::Catalog
  describe ItemType do
    describe "structure" do
      subject { ItemType.all.first }
      
      specify { subject.id.should == 1 }
      specify { subject.name.should == "track" }            
    end
  end
end
