# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jira_release/version'

Gem::Specification.new do |spec|
  spec.name          = "jira_release"
  spec.version       = JiraRelease::VERSION
  spec.authors       = ["Abdullah Jubayer"]
  spec.email         = ["ajubayer@ondeck.com", "ajsunny86@yahoo.com"]

  spec.summary       = %q{Create and release jira fix versions}
  spec.description   = %q{A utility to create and release jira fix versions}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.metadata      = { "company_name" => "OnDeck"}

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = Dir.glob("{bin,lib}/**/*")
  spec.executables   << 'jira_release'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end