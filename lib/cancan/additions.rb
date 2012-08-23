module CanCan::Additions
  # Creates an CanCan::Ability object with the roles specified.
  def cancan_ability(roles)
    @cancan_ability ||= begin
      account_with_roles = FactoryGirl.create(:account).tap do |account|
        account.roles = roles
        account.save
      end

      Account::Ability.new(account_with_roles)
    end
  end

  # This checks to see if the controller's action is available to the role and 
  # filters out the ones it can not access. 
  def cancan_ability_filter(method_object, ability)
    if method_object.path =~ /(.+)#(.+)/
      if cancan_resource_hash = $1.constantize.cancan_resource
        resource_class = cancan_resource_hash[:resource_class]
        options = cancan_resource_hash[:options]
        action = $2.to_sym

        # NOTE: Should fill out the rest of the option cases.
        if options[:only] && options[:only] != action
          false
        else
          ability.cannot?(action, resource_class)
        end
      end
    end
  end
end