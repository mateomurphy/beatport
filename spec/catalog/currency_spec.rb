require 'spec_helper'

module Beatport::Catalog
  describe Currency do
    before :each do
      VCR.insert_cassette 'currency'
    end

    after :each do
      VCR.eject_cassette
    end

    describe "structure" do
      subject { Currency.all.first }
      
      it { should be_a(Currency) }
      its (:id) { should == 1 }
      its (:code) { should == "USD" }
      its (:name) { should == "Dollar" }      
      
    end
  end
end