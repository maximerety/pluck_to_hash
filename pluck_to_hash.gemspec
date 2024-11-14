# frozen_string_literal: true

require_relative "lib/pluck_to_hash/version"

Gem::Specification.new do |spec|
  spec.name          = "pluck_to_hash"
  spec.version       = PluckToHash::VERSION
  spec.authors       = ["Girish S"]
  spec.email         = ["girish.sonawane@gmail.com"]
  spec.summary       = %q{Extend ActiveRecord pluck to return hash}
  spec.description   = %q{Extend ActiveRecord pluck to return hash instead of an array. Useful when plucking multiple columns.}
  spec.homepage      = "https://github.com/girishso/pluck_to_hash"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 7.1.0"
  spec.add_dependency "activesupport", ">= 7.1.0"
end
