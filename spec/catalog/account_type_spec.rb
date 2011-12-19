require 'spec_helper'

module Beatport::Catalog
  describe AccountType do
    describe 'structure' do
      subject { AccountType.all.first }
      
      specify { subject.code.should == "AMEX" }
      specify { subject.bpid.should == "1" }
      specify { subject.cybersource_card_type.should == "003" }
      specify { subject.issue_number_or_start_date_required.should == false }
      specify { subject.validation_regex.should == /^3[47][0-9]{13}$/ }
      specify { subject.images.small.url.should == "https://ak-secure-beatport.bpddn.com/images/creditcard/logo_cc_amex_37x23.gif"}
    end
  end
end