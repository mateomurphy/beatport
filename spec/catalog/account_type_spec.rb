require 'spec_helper'

module Beatport::Catalog
  describe AccountType do
    describe 'structure' do
      subject { AccountType.all.first }
      
      its (:code) { should == "AMEX" }
      its (:bpid) { should == "1" }
      its (:cybersource_card_type) { should == "003" }
      its (:issue_number_or_start_date_required) { should == false }
      its (:validation_regex) { should == /^3[47][0-9]{13}$/ }
      its (:'images.small.url') { should == "https://ak-secure-beatport.bpddn.com/images/creditcard/logo_cc_amex_37x23.gif"}
    end
  end
end