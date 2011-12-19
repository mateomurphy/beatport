require 'spec_helper'

module Beatport::Catalog
  describe SourceType do
    describe "structure" do
      subject { SourceType.all.first }
      
      specify { subject.id.should == 1 }
      specify { subject.name.should == "store" }            
    end
  end
end
