require 'spec_helper'

module Beatport::Catalog
  describe SourceType do
    before :each do
      VCR.insert_cassette 'source_type'
    end

    after :each do
      VCR.eject_cassette
    end

    describe "structure" do
      subject { SourceType.all.first }
      
      it { should be_a(SourceType) }
      its (:id) { should == 1 }
      its (:name) { should == "store" }            
    end
  end
end
