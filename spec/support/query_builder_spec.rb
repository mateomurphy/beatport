require 'spec_helper'

module Beatport::Support
  describe QueryBuilder do
    describe '#process_sort_by' do
      it "handles strings" do
        input = 'publish_date desc, chart_id desc'
        output = 'publishDate desc,chartId desc'
        
        QueryBuilder.new.process_sort_by(input).should == output
      end

      it "handles arrays" do
        input = ['publish_date desc', 'chart_id desc']
        output = 'publishDate desc,chartId desc'
        
        QueryBuilder.new.process_sort_by(input).should == output
      end

      it "handles hashes" do
        input = {'publish_date' => 'desc', 'chart_id' => 'desc'}
        output = 'publishDate desc,chartId desc'
        
        QueryBuilder.new.process_sort_by(input).should == output
      end
    end
    
    describe '#process_facets' do
      it "handles strings" do
        input = "genre_name:Trance, genre_name:Progressive House"
        output = "genreName:Trance,genreName:Progressive House"
        
        QueryBuilder.new.process_facets(input).should == output        
      end

      it "handles arrays" do
        input = ["genre_name:Trance", "genre_name:Progressive House"]
        output = "genreName:Trance,genreName:Progressive House"
        
        QueryBuilder.new.process_facets(input).should == output        
      end

      it "handles hashes with string values" do
        input = {"genre_name" => "Trance"}
        output = "genreName:Trance"
        
        QueryBuilder.new.process_facets(input).should == output        
      end


      it "handles hashes with array values" do
        input = {"genre_name" => ["Trance", "Progressive House"]}
        output = "genreName:Trance,genreName:Progressive House"
        
        QueryBuilder.new.process_facets(input).should == output        
      end
    end
    
    describe '#process_return_facets' do
      it "handles strings" do
        input = "genre_name, performer_name"
        output = "genreName,performerName"
        
        QueryBuilder.new.process_return_facets(input).should == output
      end
    end
    
    describe ".process" do
      it "handles sort by" do
        h = {:sort_by => ['publishDate asc', 'chartId asc']}
        
        QueryBuilder.process(h).should == {'sortBy'=>"publishDate asc,chartId asc"}
      end

      it "handles sort by with hash syntax" do
        h = {:sort_by => {'publish_date'=>'asc', 'chart_id'=>'asc'}}
        
        QueryBuilder.process(h).should == {'sortBy'=>"publishDate asc,chartId asc"}
      end

      it "handles return facets" do
        h = {:return_facets => ['genre_name', 'performer_name']}
        
        QueryBuilder.process(h).should == {'returnFacets'=>"genreName,performerName"}
      end

      it "handles facets" do
        h = {:facets => {:genre_name => ['Trance', 'Progessive House']}}
        
        QueryBuilder.process(h).should == {'facets'=>"genreName:Trance,genreName:Progessive House"}
      end
    end
  end
end