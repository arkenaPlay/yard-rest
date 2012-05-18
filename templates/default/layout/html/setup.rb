include Helpers::FilterHelper

# Implementation from yard gem; couldn't use Object#super since we need to concat :diskfile and :index
def init
  @breadcrumb = []  
  if @onefile
    sections :layout
  elsif @file
    if @file.attributes[:namespace]
      @object = options.object = Registry.at(@file.attributes[:namespace]) || Registry.root 
    end
    @breadcrumb_title = "File: " + @file.title
    @page_title = options[:title]
    sections :layout, [:diskfile, :index]
  elsif @contents
    sections :layout, [:contents]
  else
    case object
    when '_index.html'
      @page_title = options[:title]
      sections :layout, [:index, [:listing, [:files, :objects]]]
    when CodeObjects::Base
      unless object.root?
        cur = object.namespace
        while !cur.root?
          @breadcrumb.unshift(cur)
          cur = cur.namespace
        end
      end
    
      @page_title = format_object_title(object)
      type = object.root? ? :module : object.type
      sections :layout, [T(type)]
    end
  end
end

def diskfile
  @file.attributes[:markup] ||= markup_for_file('', @file.filename)
  data = htmlify(@file.contents, @file.attributes[:markup])
  "<div id='filecontents' class='service'><h1>#{@file.title}</h1>" + data + "</div>"
end

def javascripts
  super + %w(js/rest_plugin.js)
end

def menu_lists
  [ { :type => 'resource', :title => "Resources", :search_title => "Resource List" },
    { :type => 'topic', :title => "Topics", :search_title => "Topic List" },
    { :type => 'file', :title => "Files", :search_title => "File List" } ]
end

def index
  legitimate_objects = @objects.select { |o| o.has_tag?('url') }
  @topics = {}

  legitimate_objects.each do |object|
    object.tags('topic').each { |topic| (@topics[topic.text] ||= []) << object }
  end

  @resources = legitimate_objects.sort_by {|o| o.tags('url').first.text }
  @overall_objects = @objects.find_all { |o| o.has_tag?('overall') }.sort_by { |o| o.tag('overall').text }
  @routes = YARD::Rest::Routes.with_resource_links(@resources)
  erb(:index)
end