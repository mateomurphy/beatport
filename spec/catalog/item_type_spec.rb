require 'spec_helper'

module Beatport::Catalog
  describe ItemType do
    describe "structure" do
      before(:all) { @item_type = ItemType.all.first }
      it { @item_type.id.should == 1 }
      it { @item_type.name.should == "track" }            
    end
  end
end
