# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "guess_struct/version"

Gem::Specification.new do |spec|
  spec.name          = "guess_struct"
  spec.version       = GuessStruct::VERSION
  spec.authors       = ["ksss"]
  spec.email         = ["co000ri@gmail.com"]

  spec.summary       = %q(Type guess struct)
  spec.description   = %q(Type guess struct)
  spec.homepage      = "https://github.com/ksss/guess_struct"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rgot"
end
