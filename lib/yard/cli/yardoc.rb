module YARD
  module CLI
    class Yardoc
      # Adds verifier rule for APIs
      # This modifications allows for multiple @api tags to be assigned to any object.
      def add_api_verifier
        return if apis.empty?
        no_api = true if apis.delete('')
        expr = "!(#{apis.uniq.inspect} & @@api.map(&:text)).empty?"
        expr += " || !@api" if no_api
        options.verifier.add_expressions(expr)
      end
    end
  end
end