# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name                = 'yard-rest'
  s.version             = '0.4.1'

  s.add_runtime_dependency 'cancan',          '~> 1.6',   '>= 1.6.7'
  s.add_runtime_dependency 'database_cleaner','~> 1.2',   '>= 1.2.0'
  s.add_runtime_dependency 'factory_girl',    '~> 4.4',   '>= 4.4.0'
  s.add_runtime_dependency 'rails',           '~> 3.2',   '>= 3.2.17'
  s.add_runtime_dependency 'yard',            '~> 0.8',   '>= 0.8.7'

  s.authors             = [
    'R. Kevin Nelson',
    'Aisha Fenton',
    'Chris Trinh',
    'Philippe Nenert',
  ]
  s.date                = '2014-06-16'
  s.description         = 'A plugin for Yardoc that produces API documentation for Restful web services. See README.markdown for more details'
  s.email               = 'philippe.nenert@arkena.com'
  s.extra_rdoc_files    = [
    'README.markdown',
    'VERSION',
  ]
  s.files               = [
    'example/README.markdown',
    'example/SampleController.rb',
    'lib/yard-rest.rb',
    'lib/yard-rest/filters.rb',
    'lib/yard-rest/tags.rb',
    'lib/yard/cli/yardoc.rb',
    'lib/yard/handlers/ruby/comment_handler.rb',
    'lib/yard/tags/default_factory.rb',
    'Rakefile',
  ]
  s.homepage            = 'https://github.com/arkenaPlay/yard-rest'
  s.license             = 'GPL'
  s.require_paths       = ['lib']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version    = '2.2.2'
  s.summary             = 'A plugin for Yardoc that produces API documentation for Restful web services'
end
