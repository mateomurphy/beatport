require 'spec_helper'

module Beatport::Catalog
  describe Autocomplete do
    describe 'stucture' do
      before(:all) { @result = Autocomplete.query('lutzen').first }
      it { @result.name.downcase.should match(/lutzen/) }
    end
    
    describe 'collection' do
      before(:all) { @collection = Autocomplete.query('lutzen') }
      it { @collection.host.should == "api.beatport.com" }
      it { @collection.path.should == "/catalog/autocomplete" }
      it { @collection.query.should == "query=lutzen" }
      it { @collection.page.should == 1 }
      it { @collection.per_page.should == 10 }
      it { @collection.count.should be > 1 }
      it { @collection.total_pages.should be > 1 }
      it { @collection.next_query.should == "query=lutzen&page=2"}
      it { @collection.per_page_options.should_not be_nil }
      it { @collection.facets.should_not be_nil }
      it { @collection.spellcheck.should_not be_nil }
    end
  end
end