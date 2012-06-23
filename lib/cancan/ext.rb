module CanCan
  module ControllerAdditions
    module ClassMethods
      # This attribute is added to the Controller's singleton class.
      # This is need to pull out which resource or symbol the controller is responsible for, 
      # such that we can check against it with an CanCan#Ability object.
      attr_accessor :cancan_resource
    end
  end
end

module CanCan
  class ControllerResource
    # The only major change here is that we parse the resource or symbol and assign drag it up towards the 
    # controller's singleton object. 
    def self.add_before_filter(controller_class, method, *args)
      options = args.extract_options!
      resource_name = args.first
      before_filter_method = options.delete(:prepend) ? :prepend_before_filter : :before_filter

      controller_class.cancan_resource ||= begin 
        # Note: The logic here is similar to CanCan::ControllerResource#resource_class
        resource_class = case options[:class]
          when false  then controller_class.name.sub("Controller", "").underscore.gsub("/", "_").singularize.to_sym
          when String then options[:class].constantize
          else options[:class]
        end

        {:resource_class => resource_class, :options => options.slice(:only, :except, :if, :unless)}
      end

      controller_class.send(before_filter_method, options.slice(:only, :except, :if, :unless)) do |controller|
        controller.class.cancan_resource_class.new(controller, resource_name, options.except(:only, :except, :if, :unless)).send(method)
      end
    end
  end
end