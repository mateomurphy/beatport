module Beatport
  module Catalog
    class DynamicImages
      attr_reader :main, :banner, :waveform

      def initialize(images)
        images.each do |format, data|
          instance_variable_set(:"@#{format}", DynamicImage.new(data))
        end
      end
    end
  end
end
