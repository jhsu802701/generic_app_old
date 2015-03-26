# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generic_app/version'

Gem::Specification.new do |spec|
  spec.name          = "generic_app"
  spec.version       = GenericApp::VERSION
  spec.authors       = ["Jason Hsu"]
  spec.email         = ["rubyist@jasonhsu.com"]
  spec.summary       = %q{Save time by instantly create a generic Rails app.}
  spec.description   = %q{Instead of creating your Rails app from scratch, start with a generic app.}
  spec.homepage      = "https://github.com/jhsu802701/generic_app"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  
  spec.add_runtime_dependency "string_in_file"
end
