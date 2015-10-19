# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'drophunter/version'

Gem::Specification.new do |spec|
  spec.name          = "drophunter"
  spec.version       = Drophunter::VERSION
  spec.authors       = ["Airat Shigapov"]
  spec.email         = ["contact@airatshigapov.com"]

  spec.summary       = "drophunter"
  spec.homepage      = "http://github.com/airatshigapov/drophunter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["drophunter"]
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
