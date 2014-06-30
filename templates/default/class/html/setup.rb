include Helpers::ModuleHelper
include Helpers::FilterHelper

def init
  sections :header, [T('docstring'), :method_details_list, [T('method_details')]]
end

def run_method_verifier(list)
  if options.verifier && !list.empty?
    list.delete_if { |method| cancan_ability_filter(method, cancan_ability(options.verifier.roles)) unless method.has_tag?('api') }

    options.verifier.run(list)
  else
    list
  end
end

def method_details_list
  @meths = object.meths(:inherited => false, :included => false)
  @meths = index_objects(@meths)
  @meths = run_method_verifier(@meths)
  erb(:method_details_list)
end

# Major hack did not know how to find all module/class objects
# Should be able to access this partial/section thru a template.
def header
  @topics ||= begin
    objects = Registry.all(:class, :module)

    objects.delete_if do |controller_object|
      controller_object.children.all? { |method_object| cancan_ability_filter(method_object, cancan_ability(options.verifier.roles)) }
    end

    {}.tap do |topics|
      index_objects(objects).each do |object|
        object.tags('topic').each { |topic| (topics[topic.text] ||= []) << object }
      end
    end
  end

  @role = options.verifier.roles.first =~ /user/ ? "client" : options.verifier.roles.first

  erb(:header)
end
