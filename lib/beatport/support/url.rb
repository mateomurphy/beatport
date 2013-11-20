module Beatport
  module Support
    module Url
      def url
        "http://www.beatport.com/#{type}/#{slug}/#{id}"
      end
    end
  end
end
