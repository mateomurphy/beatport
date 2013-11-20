module Beatport
  module Catalog
    class DynamicImage < Item
      def dynamic_url(options = {})
        url.gsub(/{(\w*)}/) do |m|
          options[m[1...-1].to_sym]
        end
      end
    end
  end
end
