require 'spec_helper'

module Beatport::Catalog
  describe Home do
    describe '.get' do
      subject { Home.get }
        
      specify { subject.slideshow.header.length.should be >= 1 }
      specify { subject.slideshow.feature.length.should be > 1 }
      specify { subject.features.length.should be > 1 }
      specify { subject.top_downloads.length.should be > 1 }
    end
  end
end