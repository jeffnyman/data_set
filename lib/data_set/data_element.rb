require "data_set/data_accessor"

module DataSet
  class DataElement
    include DataSet::DataAccessor

    def initialize(value)
      @data_source = value
    end
  end
end
