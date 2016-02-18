# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sorry/api/version'

Gem::Specification.new do |spec|
  spec.name          = "sorry-api-ruby"
  spec.version       = Sorry::Api::VERSION
  spec.authors       = ["Robert Rawlins"]
  spec.email         = ["robert@sorryapp.com"]
  spec.summary       = "A Ruby gem for communicating with the Sorry™ API "
  spec.description   = "An easy to use Ruby wrapper for the Sorry™ Status Page API. For details on what you can do with the API please check our API Documentation."
  spec.homepage      = "https://docs.sorryapp.com/api/v1/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '>= 0.9.1'
  spec.add_dependency 'multi_json', '>= 1.11.0'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
