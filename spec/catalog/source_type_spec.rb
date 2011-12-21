require 'spec_helper'

module Beatport::Catalog
  describe SourceType do
    describe "structure" do
      subject { SourceType.all.first }
      
      it { should be_a(SourceType) }
      its (:id) { should == 1 }
      its (:name) { should == "store" }            
    end
  end
end
