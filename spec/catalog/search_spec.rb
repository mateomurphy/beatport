require 'spec_helper'

module Beatport::Catalog
  describe Search do
    before :each do
      VCR.insert_cassette 'search'
    end

    after :each do
      VCR.eject_cassette
    end

    describe '.get' do
      it "should perform a simple search with just a string" do
        results = Search.query('believe 2004')
        results.length.should be >= 1
      end
      
      it "should perform a simple search with just a string" do
        results = Search.query('Archipel')
        results.length.should be >= 1
      end      
      

      it "should not find a release by catalogue number" do
        results = Search.query("ANJCDCO011D")
        results.length.should be 0
      end
      
      it "should find all content for Anjunadeep that has something to do with Trance" do
        results = Search.query('anjunadeep', :facets => { :genre_name => 'Trance' })
        results.length.should be > 1
        results.grouped.keys.sort.should == ["Chart", "Label", "Release", "Track"]
      end
    end
  end
end