# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jira_fix_version_release/version'

Gem::Specification.new do |spec|
  spec.name          = "jira_fix_version_release"
  spec.version       = JiraFixVersionRelease::VERSION
  spec.authors       = ["Abdullah Jubayer"]
  spec.email         = ["ajubayer@ondeck.com", "ajsunny86@yahoo.com"]

  spec.summary       = %q{Create and release jira fix versions}
  spec.description   = %q{A utility to create and release jira fix versions}
  spec.homepage      = "https://github.com/abdullah-jubayer/jira_fix_version_release"
  spec.license       = "MIT"
  spec.metadata      = { "company_name" => "OnDeck"}

  spec.files         = Dir.glob("{bin,lib}/**/*")
  spec.executables   << 'jira_fix_version_release'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
