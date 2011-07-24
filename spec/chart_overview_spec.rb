require 'spec_helper'

module Beatport 
  describe ChartOverview do
    describe '.get' do
      it "should have 16 newest charts and 4 featured charts" do
        overview = ChartOverview.get
      
        overview.newest.length.should == 16
        overview.featured.length.should == 4
      end
    end
  end
end
  