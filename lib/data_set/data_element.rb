require "data_set/data_accessor"

module DataSet
  class DataElement
    include DataSet::DataAccessor

    def initialize(value)
      @data_contents = value
    end

    def to_hash
      @data_contents
    end
  end
end
