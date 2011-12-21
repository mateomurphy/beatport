module Beatport
  module Catalog
    class Autocomplete < Item
      def self.query(query, options = {})
        options['query'] = query
      
        Client.retrieve 'autocomplete', Autocomplete, options
      end
    end
  end
end