def init
  sections :header, [T('docstring'), :method_details_list, [T('method_details')]]
end

def run_verifier(list)
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
  @meths = run_verifier(@meths)
  erb(:method_details_list)
end
