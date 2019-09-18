# DataSet

[![Gem Version](https://badge.fury.io/rb/data_set.svg)](http://badge.fury.io/rb/data_set)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/jeffnyman/data_set/blob/master/LICENSE.md)

DataSet provides an easy mechanism to load up a set of data from a YAML file and then access that data by the structuring keys of the file. This provides an expressive way to retrieve data values.

## Installation

To get the latest stable release, add this line to your application's Gemfile:

```ruby
gem 'data_set'
```

To get the latest code:

```ruby
gem 'data_set', git: 'https://github.com/jeffnyman/data_set'
```

After doing one of the above, execute the following command:

```
$ bundle
```

You can also install DataSet just as you would any other gem:

```
$ gem install data_set
```

## Usage

To use DataSet you can either specify a directory and file for loading or rely on the defaults. By default, DataSet will look for files in a `data` directory relative to the executing script. Also by default, DataSet will read a file named `default.yml` from that directory. These defaults apply if you don't specify anything to the contrary.

If you want to use a different directory you can simply set the directory like this:

```ruby
DataSet.data_path = 'config'
```

If you have a specific data file you want to load, you can specify it:

```ruby
DataSet.load('test_data.yml')
```

Calling the `load` method lets you begin to reference the data from that file. You can also specify a comma separated list of file names:

```ruby
DataSet.load('test_data.yml, accounts.yml, users.yml')
```

What DataSet is providing you is not just the loading of the file but a way to access the data directly by its name.

### Data Accessors

Consider a `test_data.yml` file with the following contents:

```yaml
home_url: 'https://veilus.herokuapp.com'
port: 9292

authentication:
  username: admin
  password: admin

first:
  second:
    third: testing
    fourth: xyzzy

set_flag: true
cleared_flag: false
test_symbol: :marvel
```

Now you can load this file and begin calling methods on the DataSet that match the keys from the file.

```ruby
DataSet.load('test_data.yml')

puts DataSet.home_url
```

Here the last statement would return "https://veilus.herokuapp.com". Using this in context, I might do something like this:

```ruby
puts "#{DataSet.home_url}/planets"
```

You can also supply default values which will be returned if the property does not exist in the file. For example:

```ruby
puts "#{DataSet.home_url("http://localhost")}:#{DataSet.port}/planets"
```

Here `home_url` will be read from the file but, if it doesn't exist, the value provided to it will be used.

You can also access into the keys. For example, consider these statements:

```ruby
puts DataSet.authentication.username
puts DataSet.first.second.third
```

These statements would return the following based on the above data file:

```
admin
testing
```

You can also set an environment variable called `DATA_SET_FILE`. It's important to note that this is not a path. This is a file. The extent that this is useful depends on the context in which you slot it. Treating DataSet as an adjunct to an automated checking solution, for example, different machines that are using it could have different `DATA_SET_FILE` variables set. Or if using a tool like Cucumber, you could provide different profiles for execution like this:

  ```yaml
default:  DATA_SET_FILE=test.yml
ci:       DATA_SET_FILE=ci.yml
stage:    DATA_SET_FILE=staging.yml
prod:     DATA_SET_FILE=production.yml
```

This would allow the specific environment variable to be set conditionally based on execution.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec:all` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

The default `rake` command will run all tests as well as a RuboCop analysis.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/jeffnyman/data_set](https://github.com/jeffnyman/data_set). The testing ecosystem of Ruby is very large and this project is intended to be a welcoming arena for collaboration on yet another testing tool. As such, contributors are very much welcome but are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

To contribute to DataSet:

1. [Fork the project](http://gun.io/blog/how-to-github-fork-branch-and-pull-request/).
2. Create your feature branch. (`git checkout -b my-new-feature`)
3. Commit your changes. (`git commit -am 'new feature'`)
4. Push the branch. (`git push origin my-new-feature`)
5. Create a new [pull request](https://help.github.com/articles/using-pull-requests).

## Author

* [Jeff Nyman](http://testerstories.com)

## Credits

This code is loosely based upon the [FigNewton](https://github.com/cheezy/fig_newton) gem. I created a new version largely to avoid the name "FigNewton" as well as cleaning up the code and the documentation.

## License

DataSet is distributed under the [MIT](http://www.opensource.org/licenses/MIT) license.
See the [LICENSE](https://github.com/jeffnyman/data_set/blob/master/LICENSE.md) file for details.
