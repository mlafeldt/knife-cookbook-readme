require 'bundler/gem_tasks'
require 'rake/clean'
require 'rspec/core/rake_task'

CLEAN.include 'pkg'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --format documentation'
end

task :default => :spec
