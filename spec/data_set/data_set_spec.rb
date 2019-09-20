RSpec.describe DataSet do
  it "has a version number" do
    expect(DataSet::VERSION).not_to be nil
  end

  context "when asking for data" do
    it "retrieves the data by a key named after the method called" do
      DataSet.load("../data/yaml/test_sample.yml")
      expect(DataSet.from_the_env).to eql 'read from the env'
    end

    it "retrieves data from the default location and data file" do
      DataSet.data_contents = nil
      expect(DataSet.base_url).to eql 'http://testerstories.com'
    end
  end
end
