# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'commiter_generator'
require 'commiter_rules_generator'
require 'commiter'

Gem::Specification.new do |spec|
  spec.name          = 'commiter'
  spec.version       = Commiter::VERSION
  spec.author        = 'Yazan Tarifi'
  spec.email         = 'yazantarifi98@gmail.com'

  spec.summary       = 'Command Line Interface to Add Git Hooks On Commits to Block any Commit that does not match the Configuration inside Commiter Config Working on git commit -m'
  spec.homepage      = "https://github.com/Yazan98/commiter"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^rxr/}) { |f| File.basename(f) }

  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('simplecov')

end