# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'md_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "md_parser"
  spec.version       = MdParser::VERSION
  spec.authors       = ["Nigel Thorne"]
  spec.email         = ["gems@nigelthorne.com"]
  spec.summary       = %q{WIP: Parser for MD5 tables. }
  spec.description   = %q{Not production ready. Do not use}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "parslet", "~> 1.6"
end
