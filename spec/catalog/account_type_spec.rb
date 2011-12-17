require 'spec_helper'

module Beatport::Catalog
  describe AccountType do
    describe 'structure' do
     before(:all) { @account_type = AccountType.all.first }
     
     it { @account_type.code.should == "AMEX" }
     it { @account_type.bpid.should == "1" }
     it { @account_type.cybersource_card_type.should == "003" }
     it { @account_type.issue_number_or_start_date_required.should == false }
     it { @account_type.validation_regex.should == /^3[47][0-9]{13}$/ }
     it { @account_type.images.small.url.should == "https://ak-secure-beatport.bpddn.com/images/creditcard/logo_cc_amex_37x23.gif"}
    end
  end
end