module Beatport
  class ChartOverview < Item
    has_many :newest, Chart
    has_many :featured, Chart
    
    def self.get
      Client.retrieve 'charts/overview', ChartOverview      
    end
  end
end