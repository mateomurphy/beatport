require 'spec_helper'

module Beatport::Catalog
  describe Currency do
    describe "structure" do
      subject { Currency.all.first }
      
      it { should be_a(Currency) }
      its (:id) { should == 1 }
      its (:code) { should == "USD" }
      its (:name) { should == "Dollar" }      
      
    end
  end
end