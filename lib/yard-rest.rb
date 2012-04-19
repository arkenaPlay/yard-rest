YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/../templates'

require File.join(File.dirname(__FILE__), 'yard-rest', 'tags')
require File.join(File.dirname(__FILE__), 'yard-rest', 'rest_filters')

YARD::Templates::Template.extra_includes << RestFilters