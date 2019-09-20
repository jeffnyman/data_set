Given("the default configuration file in the default location") do
  DataSet.data_contents = nil
end

Given("the test data configuration file") do
  DataSet.data_path = "data/yaml"
  DataSet.load "test_data.yml"
end

Given(/^an environment variable named "([^\"]*)" set to "([^\"]*)"$/) do |env_name, filename|
  DataSet.data_contents = nil
  ENV[env_name] = filename
  DataSet.data_path = 'data/yaml'
  DataSet.instance_variable_set(:@data_contents, nil)
end

When("asking for the value for {string}") do |string|
  @value = DataSet.send string
end

When("asking for the element value for {string}") do |string|
  @value = @value.send string
end

When("asking for the non-existent value for {string}") do |string|
  @no_value = string
end

When(/^asking for the non-existent value for "(.+)" with default value "(.+)"$/) do |key, value|
  @value = DataSet.send key, value
end

When(/^asking for the non-existent value for "(.+)" with default block returning "(.+)"$/) do |key, value|
  @value = DataSet.send(key) { value }
end

When(/^asking for the non-existent value for "(.+)" with default lambda returning "(.+)"$/) do |key, value|
  my_lambda = lambda { |property| @lambda_property = property; return value }
  @value = DataSet.send key, &my_lambda
end

When(/^asking for the non-existent value for "(.+)" with default proc returning "(.+)"$/) do |key, value|
  my_proc = Proc.new { value }
  @value = DataSet.send key, &my_proc
end

Then("the value should be {string}") do |string|
  expect(@value).to eql string
end

Then("a NoMethodError exception is raised") do
  expect { DataSet.send(@no_value) }.to raise_error(NoMethodError)
end

Then("data set recognizes a data element") do
  expect(@value).to be_an_instance_of DataSet::DataElement
end

Then(/^the "([^\"]*)" value for the element should be "([^\"]*)"$/) do |key, value|
  expect(@value.send(key)).to eql value
end

Then("the hash of values will be:") do |table|
  expect(table.transpose.hashes.first).to eql @value.to_hash
end

Then("the value should be {int}") do |int|
  expect(@value).to eql int
end

Then("the value should be {float}") do |float|
  expect(@value).to eql float
end

Then("values of the array are {string}, {string}, {string}") do |string, string2, string3|
  array = [string, string2, string3]
  expect(@value).to eql(array)
end

Then("the value should be true") do
  expect(@value).to be true
end

Then("the value should be false") do
  expect(@value).to be false
end

Then (/^the value should be :([^\"]*)$/) do |value|
  expect(@value).to eql value.to_sym
end

Then("the lambda should be passed the property {string}") do |string|
  expect(@lambda_property).to eq(string)
end
