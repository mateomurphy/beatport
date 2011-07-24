require 'forwardable'

module Beatport
  class Collection
    include Enumerable
    extend Forwardable
    
    def_delegators :@results, :each, :'<=>', :length, :==, :===, :to_a
    
    attr_reader :page, :perPage, :count, :spellcheck, :totalPages, :dateFilters, :appliedDateFilters, :facets, :appliedFacets
    
    def initialize(klass, data)
      raise ArgumentError, "Invalid data passed to Collection.new" unless data['results'].is_a?(Array)
      
      data['metadata'].each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end
      
      @results = data['results'].map { |r| klass.new(r) }
    end
  end
end