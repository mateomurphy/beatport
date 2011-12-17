module Beatport
  module Catalog
    class Images
      attr_reader :small, :medium, :large, :waveform, :banner
    
      def initialize(images)
        images.each do |format, data|
          instance_variable_set(:"@#{format}", Image.new(data))
        end
      end
    end
  end
end