require 'spec_helper'

module Beatport::Catalog
  describe Currency do
    describe "structure" do
      before(:all) { @currency = Currency.all.first }
      it { @currency.id.should == 1 }
      it { @currency.code.should == "USD" }
      it { @currency.name.should == "Dollar" }      
      
    end
  end
end