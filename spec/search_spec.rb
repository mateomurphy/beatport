require 'spec_helper'

module Beatport 
  describe Search do
    describe '.get' do
      it "should perform a simple search with just a string" do
        results = Search.query('believe 2004')
        results.length.should be >= 1
      end
      
      it "should find all content for Anjunadepe that has something to do with Trance" do
        results = Search.query('anjunadeep', :facets => { :genre_name => 'Trance' })
        results.length.should be > 1
        
        results.grouped.keys.should == ["Track", "Label", "Release"]
      end
    end
  end
end