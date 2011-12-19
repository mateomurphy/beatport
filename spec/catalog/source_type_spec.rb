require 'spec_helper'

module Beatport::Catalog
  describe SourceType do
    describe "structure" do
      subject { SourceType.all.first }
      
      its (:id) { should == 1 }
      its (:name) { should == "store" }            
    end
  end
end
