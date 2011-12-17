module Beatport
  module Catalog  
    class Recommendations < Item
      has_many :releases, Release
    end
  end
end