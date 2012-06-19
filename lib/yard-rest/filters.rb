# This should be replace with Verifiers
module YARD::Rest
  module Filters
    def index_objects(list)
      res = reject_module(list)
      res = reject_without_url(res)
      res = reject_without_topic(res)
      res = reject_overall(res)

      res
    end

    def reject_module(list)
      list.reject { |object| [:root, :module].include?(object.type) }
    end

    def reject_without_url(list)
      list.reject { |object| [:class, :method].include?(object.type) and !object.has_tag?('url') }
    end

    def reject_without_topic(list)
      list.reject { |object| [:class].include?(object.type) and !object.has_tag?('topic') }
    end

    def reject_overall(list)
      list.reject { |object| object.has_tag?('overall') }
    end
  end
end