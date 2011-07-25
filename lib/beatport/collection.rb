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
      
      @results = if klass == :auto
        data['results'].map do |r|
          item_klass = Inflector.constantize(r['type'])
          item_klass.new(r)
        end
      else
        data['results'].map { |r| klass.new(r) }
      end
    end
    
    def grouped
      group_by { |i| i.type.capitalize }
    end
    
  end
end