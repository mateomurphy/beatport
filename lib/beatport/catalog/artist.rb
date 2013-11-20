module Beatport
  module Catalog
    class Artist < Item
      include Support::Url

      has_many :genres, Genre
      has_many :subgenres, Genre
      has_one :images, Images
      has_many :top_downloads, Track
#      has_many :featured_releases, Release

      class << self
        def all(options = {})
          Client.retrieve 'artists', Artist, options
        end

        def find(*args)
          Client.retrieve 'artists', Artist, *args
        end

        def name_facet
          :artist_name
        end
      end

      def top_downloads(options = {})
        Track.most_popular_for_artist(id, options)
      end
    end
  end
end
