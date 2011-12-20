require 'spec_helper'

module Beatport::Catalog
  describe Autocomplete do
    describe 'stucture' do
      subject { Autocomplete.query('lutzen').first }
      
      its (:'name.downcase') { should match(/lutzen/) }
    end
    
    describe 'collection' do
      subject { Autocomplete.query('lutzen') }
      
      its (:host) { should == "api.beatport.com" }
      its (:path) { should == "/catalog/autocomplete" }
      its (:query) { should == "query=lutzen" }
      its (:page) { should == 1 }
      its (:per_page) { should == 10 }
      its (:count) { should be > 1 }
      its (:total_pages) { should be > 1 }
      its (:next_query) { should == "query=lutzen&page=2"}
      its (:per_page_options) { should_not be_nil }
      its (:facets) { should_not be_nil }
      its (:spellcheck) { should_not be_nil }
    end
    
    describe '.query' do
      subject { Autocomplete.query('lutzen', :page => 3, :per_page => 2)}
      
      its (:page) { should == 3 }
      its (:per_page) { should == 2 }
    end
  end
end