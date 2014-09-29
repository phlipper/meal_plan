require "bundler/gem_tasks"

task default: :test

desc "Run all tests"
task test: [:rubocop, :rspec]

# rubocop style checker
require "rubocop/rake_task"
RuboCop::RakeTask.new

# rspec tests
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:rspec)
