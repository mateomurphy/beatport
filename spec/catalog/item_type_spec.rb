require 'spec_helper'

module Beatport::Catalog
  describe ItemType do
    describe "structure" do
      subject { ItemType.all.first }
      
      its (:id) { should == 1 }
      its (:name) { should == "track" }            
    end
  end
end
