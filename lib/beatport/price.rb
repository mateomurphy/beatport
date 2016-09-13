module Beatport
  class Price < Money
    # These defaults are no longer(?) being carried over from Money, so we redefine them here

    # Set the default bank for creating new +Money+ objects.
    self.default_bank = Bank::VariableExchange.instance

    # Set the default currency for creating new +Money+ object.
    self.default_currency = Currency.new("USD")

    # Default to using i18n
    self.use_i18n = true

    # Default to not using currency symbol assumptions when parsing
    #self.assume_from_symbol = false

    # Default to not using infinite precision cents
    self.infinite_precision = false

    # Default to bankers rounding
    self.rounding_mode = BigDecimal::ROUND_HALF_EVEN

    # Default the conversion of Rationals precision to 16
    self.conversion_precision = 16

    def initialize(*args)
      if args[0].is_a?(Hash)
        data = args[0]
        super(data['value'] || 0, data['code'])
      else
        super(*args)
      end
    end
  end
end