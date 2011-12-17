module Beatport
  class Price < Money

    def initialize(data = {})
      super(data['value'], data['code'])
    end
  end
end