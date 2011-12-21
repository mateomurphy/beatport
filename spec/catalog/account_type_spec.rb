require 'spec_helper'

module Beatport::Catalog
  describe AccountType do
    describe 'structure' do
      subject { AccountType.all.first }
      
      it { should be_an(AccountType) }
      its (:code) { should == "AMEX" }
      its (:bpid) { should == "1" }
      its (:name) { should == "American Express"}
      its (:cybersource_card_type) { should == "003" }
      its (:issue_number_or_start_date_required) { should == false }
      its (:validation_regex) { should == /^3[47][0-9]{13}$/ }
      its (:'images.small.url') { should == "https://ak-secure-beatport.bpddn.com/images/creditcard/logo_cc_amex_37x23.gif"}
    end
    
    describe '.all' do
      subject { AccountType.all }
      
      its (:length) { should be > 1 }
    end

    describe '.find' do
      context "by id" do
        pending "Isn't currently supported by beatport"
#        subject { AccountType.find(2) }
#        its (:name) { should == "Visa" }
      end
      
      context "by name" do
        subject { AccountType.find('Visa') }
        its (:name) { should == "Visa" }
      end
    end
  end
end