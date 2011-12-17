module Beatport
  module Catalog
    class AudioFormatFee < Item
      has_one :wav, Price
      has_one :aiff, Price
    end
  end
end