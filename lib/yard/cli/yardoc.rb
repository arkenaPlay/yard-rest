module YARD
  class Verifier
    # Add roles attribute so we can track when we parse out the options.
    attr_accessor :roles
  end
end

require "yard-rest/load_rails"
require "cancan/additions"

module YARD
  module CLI
    class Yardoc
      alias_method :old_initialize, :initialize

      def initialize
        YARD::CLI::Yardoc.send :include, YARD::Rest::LoadRails
        YARD::CLI::Yardoc.send :include, CanCan::Additions

        old_initialize
      end

      # By default all no @api tags are considered.
      # In addition, roles are parsed out of the api options since they will be handle differently,
      # through check against CanCan#Ability object.
      def add_api_verifier
        return if apis.empty?
        apis.delete('') # Will always have no_api tags turn on
        options.verifier.roles = @apis & Account::ROLES.map(&:to_s)
        # Removes roles from Verifier in the expression.
        expr = "#{(apis - Account::ROLES.map(&:to_s)).uniq.inspect}.include?(@api.text)"
        expr += " || !@api" # Will always have no_api tags turn on
        options.verifier.add_expressions(expr)
      end

      # This executes a custom filtering process that first checks if to see if all the controller methods/actions
      # can be access by roles specified in Yard's CLI options. If they all can not be accessed the controller is
      # removed from the list.
      def run_verifier(list)
        if options.verifier && !list.empty?
          list.delete_if do |controller_object|
            controller_object.children.all? { |method_object| cancan_ability_filter(method_object, cancan_ability(options.verifier.roles)) }
          end

          options.verifier.run(list)
        else
          list
        end
      end
    end # Yardoc
  end # CLI
end # YARD