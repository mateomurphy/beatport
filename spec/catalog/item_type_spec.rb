require 'spec_helper'

module Beatport::Catalog
  describe ItemType do
    before :each do
      VCR.insert_cassette 'item_type'
    end

    after :each do
      VCR.eject_cassette
    end

    describe "structure" do
      subject { ItemType.all.first }
      
      it { should be_an(ItemType) }
      its (:id) { should == 1 }
      its (:name) { should == "track" }            
    end
  end
end
