module Beatport
  # A custom HTTParter parse that underscores the keys of the result
  class Parser < HTTParty::Parser
    def parse
      Inflector.process_keys(super) { |k| Inflector.underscore(k) }
    end
  end
end