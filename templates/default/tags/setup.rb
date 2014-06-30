require "database_cleaner"

def init
  DatabaseCleaner.clean_with :truncation
  DatabaseCleaner.strategy = :transaction

  super

  sections :index, [:note,
                    :argument,
                    :example_request,
                    :request_field,
                    :example_response,
                    :response_field]
end

def request_field
  @tags = object.tags.find_all { |tag| tag.tag_name =~ /request_field|request_field_argument/ }
  erb('request_field')
end

def response_field
  generic_tag :response_field
end

def argument
  generic_tag :argument, :no_types => false
end


def generic_tag(name, opts = {})
  return unless object.has_tag?(name)
  @no_names = true if opts[:no_names]
  @no_types = true if opts[:no_types]
  @name = name
  out = erb('generic_tag')
  @no_names, @no_types = nil, nil
  out
end

private
def factory_response?(response_text)
  response_text[/FactoryGirl.create/] # Response won't show ids if we use FactoryGirl#build
end

def parse_response(response_text)
  response_text.gsub!(/\n|\t/, "")
  text = response_text[/\A{.+\=\>.+}\Z/] ? response_text : "{#{response_text}}"
  DatabaseCleaner.start
  data = eval(text)
  DatabaseCleaner.clean

  # Convert to JSON first for identation issues.
  { :xml  => data.as_json.to_xml(:root => 'response', :skip_types => true, :indent => 2, :dasherize => false,
                                 :skip_instruct => true),
    :json => JSON.pretty_generate({response: data}.as_json, :max_nesting => false) }
end

def parse_out_xml_response(response_text)
  xml_text      = response_text.match(/(<response>[\s\S]+<\/response>)/).try("[]", 1) || ""
  xml_text      = xml_text.gsub(/\<\!\[CDATA\[\n|\<\!\[CDATA\[/, "").gsub(/\]\]\>\n|\]\]\>/, "")
  plain_text    = response_text.gsub(/<response>[\s\S]+<\/response>/, "")
  [plain_text, xml_text]
end

def xml_to_json(response_text)
  xml_str = response_text.gsub(/\n\s*/, "").match(/(<response[^>]*>.*?<\/response>)/)[1]
  JSON.pretty_generate(Hash.from_xml(xml_str), :max_nesting => false)
end