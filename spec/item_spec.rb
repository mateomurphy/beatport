require 'spec_helper'

module Beatport
  describe Item do
    describe '.new' do
      it "should raise an error when given invalid data" do
        expect { Item.new(1) }.to raise_exception(ArgumentError)
      end
    end
  end
end