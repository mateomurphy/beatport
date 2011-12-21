module Beatport
  module Catalog  
    class Mixed
      def self.all(options = {})
        Client.retrieve 'mixed', :auto, options
      end
    end
  end
end