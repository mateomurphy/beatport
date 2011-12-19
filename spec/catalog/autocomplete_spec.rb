require 'spec_helper'

module Beatport::Catalog
  describe Autocomplete do
    describe 'stucture' do
      subject { Autocomplete.query('lutzen').first }
      
      specify { subject.name.downcase.should match(/lutzen/) }
    end
    
    describe 'collection' do
      subject { Autocomplete.query('lutzen') }
      
      specify { subject.host.should == "api.beatport.com" }
      specify { subject.path.should == "/catalog/autocomplete" }
      specify { subject.query.should == "query=lutzen" }
      specify { subject.page.should == 1 }
      specify { subject.per_page.should == 10 }
      specify { subject.count.should be > 1 }
      specify { subject.total_pages.should be > 1 }
      specify { subject.next_query.should == "query=lutzen&page=2"}
      specify { subject.per_page_options.should_not be_nil }
      specify { subject.facets.should_not be_nil }
      specify { subject.spellcheck.should_not be_nil }
    end
  end
end