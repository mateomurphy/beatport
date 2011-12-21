require 'spec_helper'

module Beatport::Catalog
  describe ChartOverview do
    describe '.get' do
      subject { ChartOverview.get }
      
      it { should be_a(ChartOverview) }
      its (:'newest.length') { should == 16 }
      its (:'featured.length') { should == 4 }
    end
  end
end
  