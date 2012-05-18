YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/../templates'

require "yard-rest/tags"
require "yard-rest/filters"
require "yard/handlers/ruby/comment_handler"
require "yard/tags/default_factory"

YARD::Templates::Template.extra_includes << YARD::Rest::Filters