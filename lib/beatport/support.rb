module Beatport
  module Support
    def self.constantize(string)
      Beatport.const_get(string.capitalize)      
    end
  end
end