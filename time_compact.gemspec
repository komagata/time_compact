# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_compact/version'

Gem::Specification.new do |spec|
  spec.name          = "time_compact"
  spec.version       = TimeCompact::VERSION
  spec.authors       = ["Masaki Komagata"]
  spec.email         = ["komagata@gmail.com"]
  spec.summary       = %q{Displays time compactly.}
  spec.description   = %q{Displays time compactly.}
  spec.homepage      = "https://github.com/komagata/time_compact"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'i18n'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
