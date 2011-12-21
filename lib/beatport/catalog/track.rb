module Beatport
  module Catalog  
    class Track < Item
      has_many :genres, Genre
      has_many :sub_genres, Genre
      has_many :artists, Artist
      has_many :charts, Chart
      has_one :release, Release
      has_one :label, Label
      has_one :price, Price
      has_one :images, Images
      has_one :audio_format_fee, AudioFormatFee
      has_one :key, Keys
    
      # Returns the track with the given id
      def self.find(key)
        Client.retrieve 'tracks', Track, :key => key
      end
  
      # Returns all the tracks matching the criterea
      def self.all(options = {})
        Client.retrieve 'tracks', Track, options
      end    
    
      def self.most_popular(options = {})
        Client.retrieve 'most-popular', Track, options
      end
    
      def self.most_popular_for_genre(id, options = {})
        options[:id] = id
        options[:collection] = true
        Client.retrieve "most-popular/genre", Track, options
      end
    
      def self.most_popular_for_artist(id, options = {})
        options[:id] = id
        options[:collection] = true
        Client.retrieve "most-popular/artist", Track, options
      end

      def self.most_popular_for_label(id, options = {})
        options[:id] = id
        options[:collection] = true
        Client.retrieve "most-popular/label", Track, options
      end
    
    end
  end
end