require 'spec_helper'

module Beatport::Catalog
  describe Currency do
    describe "structure" do
      subject { Currency.all.first }
      
      specify { subject.id.should == 1 }
      specify { subject.code.should == "USD" }
      specify { subject.name.should == "Dollar" }      
      
    end
  end
end