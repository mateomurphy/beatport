module Beatport
  module Catalog
    class Keys  < Item
      has_one :standard, Key
    end
  end
end