require 'spec_helper'

module Beatport 
  describe Price do
    subject :price do
      Price.new({"code" => "usd", "symbol" => "$", "value" => 1490})
    end

    describe 'defaults' do
      it "should have the same rounding_mode" do
        Price.rounding_mode.should eq(Money.rounding_mode)
      end
      
      it "should have the same precision" do
        Price.conversion_precision.should eq(Money.conversion_precision)
      end
      
    end
    
    describe '#to_s' do
      it "can be converted to a string" do
        price.to_s.should eq('14.90')
      end

      it "is equivalent to a given money object" do
        price.to_s.should eq(Money.new(1490, 'usd').to_s)
      end
    end
  end
end
    