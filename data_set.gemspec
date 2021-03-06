# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_set/version'

Gem::Specification.new do |spec|
  spec.name          = "data_set"
  spec.version       = DataSet::VERSION
  spec.authors       = ["Jeff Nyman"]
  spec.email         = ["jeffnyman@gmail.com"]

  spec.summary       = %q{Provides configuration specification and retrieval using YAML files.}
  spec.description   = %q{Provides configuration specification and retrieval using YAML files.}
  spec.homepage      = "https://github.com/jeffnyman/data_set"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber", "~> 3.0"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "data_reader"

  spec.post_install_message = %{
(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)
  DataSet #{DataSet::VERSION} has been installed.
(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)
  }
end
