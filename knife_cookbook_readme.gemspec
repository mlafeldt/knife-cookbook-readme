# -*- encoding: utf-8 -*-
require File.expand_path('../lib/knife_cookbook_readme/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ['Mathias Lafeldt']
  s.email         = ['mathias.lafeldt@gmail.com']
  s.description   = %q{Knife plugin to generate README.md from metadata.rb}
  s.summary       = s.description
  s.homepage      = 'http://mlafeldt.github.com/knife-cookbook-readme'
  s.license       = 'Apache 2.0'

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.name          = 'knife-cookbook-readme'
  s.require_paths = ['lib']
  s.version       = KnifeCookbookReadme::VERSION

  s.add_dependency 'chef'
  s.add_dependency 'erubis'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.14'
end
