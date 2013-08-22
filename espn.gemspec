# -*- encoding: utf-8 -*-
require File.expand_path('../lib/espn/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'espn'
  s.version     = ESPN::VERSION.dup
  s.platform    = Gem::Platform::RUBY

  s.authors     = ['Andrew Thorp']
  s.email       = ['andrewpthorp@gmail.com']
  s.homepage    = 'http://github.com/andrewpthorp/espn'
  s.description = %q{Simple wrapper for the ESPN v1 API.}
  s.summary     = s.description

  s.add_runtime_dependency 'addressable', '~> 2.2'
  s.add_runtime_dependency 'faraday', '~> 0.8'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.8'
  s.add_runtime_dependency 'hashie', '~> 1.2'
  s.add_runtime_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'oauth', '~> 0.4'

  s.files = %w(LICENSE.md README.md espn.gemspec)
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("spec/**/*")

  s.test_files    = Dir.glob("spec/**/*")
  s.require_paths = ["lib"]
end
