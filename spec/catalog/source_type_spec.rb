require 'spec_helper'

module Beatport::Catalog
  describe SourceType do
    describe "structure" do
      subject do
        VCR.use_cassette("source_type_all") { SourceType.all.first }
      end
      
      it { should be_a(SourceType) }
      its (:id) { should == 1 }
      its (:name) { should == "store" }            
    end
  end
end
