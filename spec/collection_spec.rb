require 'spec_helper'

module Beatport 
  describe Collection do
    describe '.new' do
      it "should raise an error when given invalid data" do
        expect { Collection.new(Item, 1) }.to raise_exception
      end
    end
  end
end