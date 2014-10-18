# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typekit_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "typekit_cli"
  spec.version       = TypeKitCli::VERSION
  spec.authors       = ["Marko Iskander"]
  spec.email         = ["markoiskander@gmail.com"]
  spec.summary       = %q{Command line interface to interact with your type kit kits and associated font families.}
  spec.description   = %q{Command line interface to interact with your type kit kits and associated font families.}
  spec.homepage      = "https://github.com/miskander/typekit_cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['typekit']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency 'thor', '~> 0.19', '>= 0.19.1'
  spec.add_dependency 'formatador', '~> 0.2', '>= 0.2.5'
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency 'rake', '~> 10.3', '>= 10.3.2'
end
