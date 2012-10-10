require 'spec_helper'

module Beatport::Catalog
  describe Search do
    describe '.get' do
      it "should perform a simple search with just a string" do
        VCR.use_cassette("search_believe_2004") do
          results = Search.query('believe 2004')
          results.length.should be >= 1
        end
      end
      
      it "should perform a simple search with just a string" do
        VCR.use_cassette("search_archipel") do
          results = Search.query('Archipel')
          results.length.should be >= 1
        end
      end      
      

      it "should not find a release by catalogue number" do
        VCR.use_cassette("search_ANJCDCO011D") do        
          results = Search.query("ANJCDCO011D")
          results.length.should be 0
        end
      end
      
      it "should find all content for Anjunadeep that has something to do with Trance" do
        VCR.use_cassette("search_anjunadeep_genre_trance") do         
          results = Search.query('anjunadeep', :facets => { :genre_name => 'Trance' })
          results.length.should be > 1
          
          results.grouped.keys.sort.should == ["Chart", "Label", "Release", "Track"]
        end
      end
    end
  end
end