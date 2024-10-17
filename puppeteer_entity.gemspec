# frozen_string_literal: true

require_relative "lib/puppeteer_entity/version"

Gem::Specification.new do |spec|
  spec.name = "puppeteer_entity"
  spec.version = PuppeteerEntity::VERSION
  spec.authors = [ "Tomas Celizna", "Asger Behncke Jacobsen" ]
  spec.email = [ "mail@tomascelizna.com", "a@asgerbehnckejacobsen.dk" ]

  spec.summary = "A Ruby gem for interacting with Puppeteer"
  spec.description = "PuppeteerEntity provides a simple and intuitive interface for interacting with Puppeteer, a headless Chrome browser."
  spec.homepage = "https://github.com/tomasc/puppeteer_entity"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tomasc/puppeteer_entity"
  spec.metadata["changelog_uri"] = "https://github.com/tomasc/puppeteer_entity/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = [ "lib" ]

  spec.add_dependency "dry-struct"
  spec.add_dependency "http"
  spec.add_dependency "zeitwerk"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "pdf-reader"
  spec.add_development_dependency "rubocop-rails-omakase"
end
