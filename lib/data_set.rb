require "data_set/version"
require "data_set/data_element"
require "data_set/data_accessor"

require "data_reader"

module DataSet
  extend DataReader
  extend DataSet::DataAccessor

  class << self
    attr_accessor :data

    def default_data_path
      'data'
    end
  end
end
