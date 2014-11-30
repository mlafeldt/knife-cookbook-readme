require 'bundler/gem_tasks'
require 'rake/clean'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

CLEAN.include 'pkg'

desc 'Run RuboCop style and lint checks'
Rubocop::RakeTask.new(:rubocop)

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --format documentation'
end

desc 'Run all tests'
task :test => [:rubocop, :spec]
task :default => :test
