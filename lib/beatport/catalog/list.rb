module Beatport
  module Catalog
    class List < Item
      has_many :items, Release
    end
  end
end