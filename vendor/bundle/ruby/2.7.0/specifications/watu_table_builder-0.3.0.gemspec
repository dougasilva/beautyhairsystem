# -*- encoding: utf-8 -*-
# stub: watu_table_builder 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "watu_table_builder".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Petrik de Heus".freeze, "Andrew C. Greenberg".freeze, "Jason Cheong-Kee-You".freeze, "J. Pablo Fern\u00E1ndez".freeze]
  s.date = "2012-02-13"
  s.description = "Rails builder for creating tables and calendars inspired by ActionView's FormBuilder.".freeze
  s.email = ["pupeno@watuhq.com".freeze]
  s.homepage = "https://github.com/watu/table_builder".freeze
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Rails builder for creating tables and calendars inspired by ActionView's FormBuilder.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_development_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_development_dependency(%q<actionpack>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<actionpack>.freeze, [">= 0"])
  end
end
