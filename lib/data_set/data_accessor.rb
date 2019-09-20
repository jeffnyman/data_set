require "yaml"

module DataSet
  module DataAccessor
    def method_missing(*args, &block)
      load_data_source unless @data_contents
      key = args.first
      value = @data_contents[key.to_s]
      value = args[1] if value.nil?
      value = yield(key.to_s) if value.nil? && block
      super if value.nil?
      value = DataSet::DataElement.new(value) unless type_known?(value)
      value
    end

    def respond_to_missing?(*args)
      super
    end

    def load_data_source
      @data_contents = nil
      path = "#{data_path}/#{ENV['DATA_SET_FILE']}"

      if ENV['DATA_SET_FILE']
        @data_contents = ::YAML.safe_load(ERB.new(
          File.read(path)
        ).result(binding))
      end

      DataSet.load('default.yml') if @data_contents.nil?
    end

    private

    def type_known?(value)
      known_types = [String, Integer, TrueClass, FalseClass,
                     Symbol, Float, Array]
      known_types.any? { |type| value.is_a?(type) }
    end
  end
end
