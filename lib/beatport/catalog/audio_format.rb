module Beatport
  module Catalog
    class AudioFormat < Item
      
      # Returns the audio format with the name given
      def self.find(key)
        Client.retrieve('audio-formats', AudioFormat, :key => key).first
      end
            
      def self.all
        Client.retrieve 'audio-formats', AudioFormat
      end
    end
  end
end