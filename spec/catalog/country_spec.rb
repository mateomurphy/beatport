require 'spec_helper'

module Beatport::Catalog
  describe Country do
    describe 'structure' do
      before(:all) { @country = Country.find('au') }
      it { @country.id.should ==  5 }
      it { @country.code.should == "AUS" }
      it { @country.code_short.should == "AU" }
      it { @country.name.should == "Australia" }
      it { @country.vat_enabled.should == false }
      it { @country.vat_rate.should == 0 }
      it { @country.iso3166_3.should == "AUS" }
      it { @country.iso3166_2.should == "AU" }
      it { @country.currency.code.should == "USD" }
      it { @country.currency.name.should == "Dollar" }
      it { @country.states.first.code.should == 'ACT' }
      it { @country.states.first.type.should == 'territory' } 
      it { @country.states.first.name.should == "Australian Capital Territory" }
    end
  end
end