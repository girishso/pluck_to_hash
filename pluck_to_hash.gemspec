# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pluck_to_hash/version'

Gem::Specification.new do |spec|
  spec.name          = "pluck_to_hash"
  spec.version       = PluckToHash::VERSION
  spec.authors       = ["Girish S"]
  spec.email         = ["girish.sonawane@gmail.com"]
  spec.summary       = %q{Extend ActiveRecord pluck to return hash}
  spec.description   = %q{Extend ActiveRecord pluck to return hash instead of an array. Useful when plucking multiple columns.}
  spec.homepage      = "https://github.com/girishso/pluck_to_hash"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "values", "~> 1.8"

  spec.add_dependency "activerecord", ">= 4.0.2"
  spec.add_dependency "activesupport", ">= 4.0.2"
end
