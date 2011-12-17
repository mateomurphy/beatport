module Beatport
  module Catalog  
    class Search
      def self.query(query, options = {})
        options['query'] = query
      
        Client.retrieve('search', :auto, options)
      end
    end
  end
end