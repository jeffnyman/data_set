#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rdoc/task"
require "rubocop/rake_task"
require "rspec/core/rake_task"
require "cucumber/rake/task"

RuboCop::RakeTask.new

namespace :spec do
  desc 'Clean all generated reports'
  task :clean do
    system('rm -rf spec/reports')
    system('rm -rf spec/coverage')
  end

  RSpec::Core::RakeTask.new(all: :clean) do |config|
    options  = %w[--color]
    options += %w[--format documentation]
    options += %w[--format html --out spec/reports/unit-test-report.html]

    config.rspec_opts = options
  end
end

desc "Run all feature specs"
task :features do
  Cucumber::Rake::Task.new(:features) do |t|
  end
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.main = 'README.md'
  rdoc.title = "DataSet #{DataSet::VERSION}"
  rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end

task default: ['spec:all', 'features', :rubocop]
