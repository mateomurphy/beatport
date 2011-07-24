module Beatport
  class List < Item
    has_many :items, Release
  end
end