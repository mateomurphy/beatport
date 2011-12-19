require 'spec_helper'

module Beatport::Catalog
  describe ChartOverview do
    describe '.get' do
      subject { ChartOverview.get }
      
      specify {subject.newest.length.should == 16 }
      specify {subject.featured.length.should == 4 }
    end
  end
end
  