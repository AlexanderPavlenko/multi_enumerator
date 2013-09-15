# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_enumerator/version'

Gem::Specification.new do |spec|
  spec.name          = "multi_enumerator"
  spec.version       = MultiEnumerator::VERSION
  spec.authors       = ["AlexanderPavlenko"]
  spec.email         = ["alerticus@gmail.com"]
  spec.description   = %q{Simultaneously process multiple enumerators}
  spec.summary       = %q{MultiEnumerator}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
end
