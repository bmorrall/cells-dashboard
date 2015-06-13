# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cells/dashboard/version'

Gem::Specification.new do |spec|
  spec.name          = "cells-dashboard"
  spec.version       = Cells::Dashboard::VERSION
  spec.authors       = ["Ben Morrall"]
  spec.email         = ["bemo56@hotmail.com"]
  spec.summary       = %q{A Simple DSL for rendering Cells as a Dashboard}
  spec.description   = %q{Adds a DSL to the apotonick/cells gem that allows for grouping of cells (as widgets) into multiple independent Dashboards}
  spec.homepage      = "https://github.com/bmorrall/cells-dashboard"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'cells', '~> 4.0.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
