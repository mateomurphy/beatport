module Beatport
  class Images
    attr_reader :small, :medium, :large
    
    def initialize(images)
      images.each do |format, data|
        instance_variable_set(:"@#{format}", Image.new(data))
      end
    end
  end
end