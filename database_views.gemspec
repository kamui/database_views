# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "database_views/version"

Gem::Specification.new do |s|
  s.name        = "database_views"
  s.version     = DatabaseViews::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jack Chu"]
  s.email       = ["jack@jackchu.com"]
  s.homepage    = "https://github.com/kamui/database_views"
  s.summary     = %q{Rails gem to store view templates in your database.}
  s.description = %q{Rails gem to store view templates in your database. Current supports only Mongoid.}

  s.rubyforge_project = "database_views"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rails", "~> 3.0"

  s.add_development_dependency "rails", "~> 3.2"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
end