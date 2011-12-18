module Beatport
  module Catalog
    class AudioFormat < Item
      
      def self.all
        Client.retrieve 'audio-formats', AudioFormat
      end
    end
  end
end