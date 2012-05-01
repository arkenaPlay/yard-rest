def init
  sections :header, [:method_url, T('docstring')]
end

def header
  erb(:header)
end
