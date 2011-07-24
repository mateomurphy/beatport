require 'ostruct'

module Beatport
  class Price
    attr_reader :usd, :eur, :gbp
    
    def initialize(prices)
      prices.each do |currency, cents|
        instance_variable_set(:"@#{currency}", Money.new(cents, currency))
      end
    end
    
  end
end