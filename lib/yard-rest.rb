load "cancan/ext.rb"
load "yard/cli/yardoc.rb" # Need to load the file to monkey patch Yardoc class.

YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/../templates'

require "yard-rest/tags"
require "yard-rest/filters"
require "yard-rest/routes"
require "yard/handlers/ruby/comment_handler"
require "yard/tags/default_factory"
require "cancan/yard_additions"

YARD::Templates::Template.extra_includes << YARD::Rest::Filters
YARD::Templates::Template.extra_includes << CanCan::YardAdditions