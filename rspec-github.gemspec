lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec/github/version"

Gem::Specification.new do |spec|
  spec.name          = "rspec-github"
  spec.version       = RSpec::GitHub::VERSION
  spec.authors       = ["Christoph Lupprich"]
  spec.email         = ["christoph@luppri.ch"]

  spec.summary       = %q{RSpec formatter that outputs errors as GitHub Actions' annotations}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/clupprich/rspec-github"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/clupprich/rspec-github/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "guard", "~> 2.16"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
end
