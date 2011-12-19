require 'spec_helper'

module Beatport::Catalog
  describe Country do
    describe 'structure' do
      subject { Country.find('au') }
      
      specify { subject.id.should ==  5 }
      specify { subject.code.should == "AUS" }
      specify { subject.code_short.should == "AU" }
      specify { subject.name.should == "Australia" }
      specify { subject.vat_enabled.should == false }
      specify { subject.vat_rate.should == 0 }
      specify { subject.iso3166_3.should == "AUS" }
      specify { subject.iso3166_2.should == "AU" }
      specify { subject.currency.code.should == "USD" }
      specify { subject.currency.name.should == "Dollar" }
      specify { subject.states.first.code.should == 'ACT' }
      specify { subject.states.first.type.should == 'territory' } 
      specify { subject.states.first.name.should == "Australian Capital Territory" }
    end
  end
end