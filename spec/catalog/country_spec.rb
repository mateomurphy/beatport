require 'spec_helper'

module Beatport::Catalog
  describe Country do
    before :each do
      VCR.insert_cassette 'country'
    end

    after :each do
      VCR.eject_cassette
    end

    describe 'structure' do
      subject { Country.find('au') }

      it { should be_a(Country) }
      its (:id) { should ==  5 }
      its (:code) { should == "AUS" }
      its (:code_short) { should == "AU" }
      its (:name) { should == "Australia" }
      its (:vat_enabled) { should == "0" }
      its (:vat_rate) { should == 0 }
      its (:iso3166_3) { should == "AUS" }
      its (:iso3166_2) { should == "AU" }
      its (:'currency.code') { should == "AUD" }
      its (:'currency.name') { should == "Australian Dollar" }
      its (:'states.first.code') { should == 'ACT' }
      its (:'states.first.type') { should == 'territory' }
      its (:'states.first.name') { should == "Australian Capital Territory" }
    end
  end
end
