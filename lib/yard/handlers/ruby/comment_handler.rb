# Beware of dragons!
# This is a horrible hack that is necessary to show nested routes.
YARD::Handlers::Ruby.send(:remove_const, :CommentHandler) if YARD::Handlers::Ruby.const_defined?(:CommentHandler)

class YARD::Handlers::Ruby::CommentHandler < YARD::Handlers::Ruby::Base
  handles :comment
  namespace_only

  process do
    meth = fake_method_name
    nobj = namespace
    mscope = scope

    obj = register MethodObject.new(nobj, meth, mscope) do |o|
      o.signature = "def #{fake_method_name}"
      o.explicit = true
      o.parameters = []
    end
  end

  def fake_method_name
    @method_name ||= begin
      hash = Object.new.hash.to_s.sub("-", "_")
      "__ROUTES__#{hash}"
    end
  end
end