require 'spec_helper'

# TODO improve this
module Beatport::Catalog
  describe Genre do
    
    describe "structure" do
      subject { Genre.find(7) }

      its (:name) { should == "Trance" }
      its (:slug) { should == "trance" }
      its (:'subgenres.length') { should be > 1}
      its (:'slideshow.header.length') { should be > 1 }
      its (:'slideshow.small.length') { should be > 1 }
      its (:'top_downloads.length') { should be > 1 }
#      it { @genre.features.length.should be > 1}
    end
    
    describe '.find' do
      it "should retrieve information about the trance genre via its id" do
        genre = Genre.find(7)
        genre.name.should == "Trance"
=begin
        genre.features.each do |feature|
          if feature.autoload
            feature.items.length.should be > 1
            feature.items.first.class.to_s.should == "Beatport::Catalog::#{feature.type}"
          end
        end
=end
      end

      it "should return nil with an invalid id" do
        genre = Beatport::Catalog.genre(9999999)
        genre.should be nil
      end
    end
  
    describe '.all' do
      it "should retrieve all genres" do
        genres = Genre.all
        genres.length.should > 1
        genres.length.should == genres.count
        genres.length.should == genres.per_page
      end
  
      it "should retrieve genres with their subgenres" do
        genres = Genre.all(:subgenres => true)
        genres.first.subgenres.length.should be > 1
      end
  
      it "should retrieve information about the trance genre via the slug" do
        Genre.all('trance').first.name.should == "Trance"
      end

      it "should retrieve information about the trance genre via the slug passed as a symbol" do
        Genre.all(:trance).first.name.should == "Trance"
      end
    
      it "should retrieve information about the trance genre via its id" do
        Genre.all(7).first.name.should == "Trance"
      end
    end
    
    describe '.overview' do
      it "should retrieve an overview" do
        overview = Genre.overview
        overview.length.should be > 0
        overview.each do |genre|
          genre.counts.releases.should be > 0
        
          # This fails for glitch hop?
          # genre.list.items.length.should == 3
        end
      end
      
    end

    describe '#top_downloads' do
      it "should return the top downloads of a genre loaded via find" do
        genre = Genre.find(7)
        genre.top_downloads.length.should == 10
      end
      
      it "should return the top downloads of a genre loaded via all" do
        genre = Genre.all(7).first
        genre.top_downloads.length.should == 10
      end
      
      it "should return the same downloads no matter how the genre was loaded" do
        by_find = Genre.find(7)
        by_all = Genre.all(7).first
        
        by_find.top_downloads.map(&:id).should == by_all.top_downloads.map(&:id)
      end
    end
    
    describe '#slideshow' do
      it "should return the slideshow of a genre loaded via find" do
        genre = Genre.find(7)
        genre.slideshow.header.length.should be > 1
      end
      
      it "should return the slideshow of a genre loaded via all" do
        genre = Genre.all(7).first
        genre.slideshow.header.length.should be > 1
      end
    
      it "should return the same slideshow no matter how the genre was loaded" do
        by_find = Genre.find(7)
        by_all = Genre.all(7).first
        
        by_find.slideshow.header.map(&:link).should == by_all.slideshow.header.map(&:link)
      end    
    end    
  end
end

