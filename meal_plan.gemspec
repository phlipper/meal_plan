# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "meal_plan/version"

Gem::Specification.new do |spec|
  spec.name          = "meal_plan"
  spec.version       = MealPlan::VERSION
  spec.authors       = ["Phil Cohen"]
  spec.email         = ["github@phlippers.net"]
  spec.summary       = "A healthy, delicious way to prepare your infrastructure"
  spec.description   = "A healthy, delicious way to prepare your infrastructure"
  spec.homepage      = "https://github.com/phlipper/meal_plan"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
end
