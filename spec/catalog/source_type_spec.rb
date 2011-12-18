require 'spec_helper'

module Beatport::Catalog
  describe SourceType do
    describe "structure" do
      before(:all) { @source_type = SourceType.all.first }
      it { @source_type.id.should == 1 }
      it { @source_type.name.should == "store" }            
    end
  end
end
