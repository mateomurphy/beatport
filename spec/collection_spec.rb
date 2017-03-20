require 'spec_helper'

module Beatport
  describe Collection do
    let :data do
      JSON.parse('{"metadata":{"host":"api.beatport.com","path":"\/catalog\/autocomplete","query":"query=lutzen","page":1,"perPage":10,"count":39,"totalPages":4,"nextQuery":"query=lutzen&page=2","perPageOptions":[{"value":50,"applyQuery":"query=lutzen&perPage=50"},{"value":100,"applyQuery":"query=lutzen&perPage=100"},{"value":150,"applyQuery":"query=lutzen&perPage=150"}],"facets":{"fields":[]},"spellcheck":{"suggestions":[]}},"results":[{"name":"Lutzencraft"},{"name":"Lutzenfierht"},{"name":"Lutzenkirchen"},{"name":"Lutzenkirchin"},{"name":"LXR aka Lutzenkirchen"},{"name":"LXR aka Lutzenkrichen"},{"name":"Tobias Lutzenkirchen"},{"name":"Lutzenkirchen Top 10"},{"name":"Lutzenkirchen Best Of"},{"name":"Lutzenkirchen Charts"}]}')
    end

    subject :collection do
      Collection.new(Item, data)
    end

    describe 'array methods' do
      [:each, :'<=>', :length, :==, :===, :[], :to_a].each do |method|
        it "responds to ##{method}" do
          collection.should respond_to(method)
        end
      end
    end

    describe '.new' do
      it "should raise an error when given invalid data" do
        expect { Collection.new(Item, 1) }.to raise_exception(ArgumentError)
      end
    end
  end
end
