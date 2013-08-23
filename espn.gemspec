# -*- encoding: utf-8 -*-
require File.expand_path('../lib/espn/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'espn'
  s.version     = ESPN::VERSION.dup

  s.author      = 'Andrew Thorp'
  s.email       = 'andrewpthorp@gmail.com'
  s.homepage    = 'http://github.com/andrewpthorp/espn'

  s.license = 'MIT'
  s.summary = 'Simple wrapper for the ESPN API.'
  s.description = <<-EOF
    A ruby wrapper for the ESPN Developer API. Their API allows you to get
    sports, leagues, scores, standings, the latest news and more. This is a
    wrapper around that API so you can pull it into your applications with ruby.
  EOF

  s.add_dependency 'addressable', '~> 2.2'
  s.add_dependency 'faraday', '~> 0.8'
  s.add_dependency 'faraday_middleware', '~> 0.8'
  s.add_dependency 'hashie', '~> 1.2'
  s.add_dependency 'multi_json', '~> 1.3'
  s.add_dependency 'oauth', '~> 0.4'
  s.add_dependency 'uri_template', '~> 0.6'

  s.files = %w(LICENSE.md README.md espn.gemspec)
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("spec/**/*")

  s.test_files    = Dir.glob("spec/**/*")
  s.require_paths = ["lib"]
end
