# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "goalseek/version"

Gem::Specification.new do |spec|
  spec.name          = "goalseek"
  spec.version       = GoalSeek::VERSION
  spec.authors       = ["Pascal Ehlert"]
  spec.email         = ["pascal@threerabbits.io"]

  spec.summary       = %q{Ruby implementation of Microsoft Excel's GoalSeek macro.}
  spec.description   = %q{Ruby implementation of Microsoft Excel's GoalSeek macro.
                          Uses a simple linear bisection method.}
  spec.homepage      = "https://github.com/pehlert/goalseek"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
