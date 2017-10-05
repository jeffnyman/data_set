RSpec.describe DataSet do
  it "has a version number" do
    expect(DataSet::VERSION).not_to be nil
  end

  context "when asking for data" do
    it "retrieves the data by a key named after the method called" do
      DataSet.data_path = "config"
      data_mock = {'some_data' => 'value'}
      expect(File).to receive(:read).with('config/my_data').and_return('my_data')
      expect(YAML).to receive(:load).and_return(data_mock)
      DataSet.load('my_data')
      expect(DataSet.some_data).to eql 'value'
    end
  end
end
