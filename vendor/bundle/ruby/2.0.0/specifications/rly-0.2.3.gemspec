# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rly"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Vladimir Pouzanov"]
  s.date = "2013-01-03"
  s.description = "A simple ruby implementation of lex and yacc, based on Python's ply"
  s.email = ["farcaller@gmail.com"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "A simple ruby implementation of lex and yacc, based on Python's ply"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
