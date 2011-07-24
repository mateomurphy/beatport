module Beatport
  class Recommendations < Item
    has_many :releases, Release
  end
end