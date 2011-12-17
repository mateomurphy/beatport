module Beatport
  class Price < Money

    def initialize(data = {})
      super(data['value'] || 0, data['code'])
    end
  end
end