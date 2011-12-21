require 'spec_helper'

module Beatport::Catalog
  describe ItemType do
    describe "structure" do
      subject { ItemType.all.first }
      
      it { should be_an(ItemType) }
      its (:id) { should == 1 }
      its (:name) { should == "track" }            
    end
  end
end
