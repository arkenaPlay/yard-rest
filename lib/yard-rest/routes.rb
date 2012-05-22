module YARD::Rest
  class Routes 
    class << self
      def with_resource_links(resources)
        resource_path = ""
        resource_index = 0

        all_routes = Rails.application.routes.routes # Journey::Routes object
        all_routes.to_a.map do |route|
          link_object = resource(route, resources)
          resource_index = if(!link_object.nil? && link_object.path == resource_path)
            resource_index + 1
          elsif !link_object.nil? && !link_object.path.nil?
            resource_path = link_object.path
            0
          end

          {:verb => verb(route), :path => path(route), :link_object => link_object, :resource_index => resource_index}
        end.reject do |route_hash| 
          route_hash[:link_object].nil? || route_hash[:verb].blank?
        end
      end

      def resource(route, resources)
        if controller_name = route.requirements[:controller]
          controller_class =  "#{controller_name}_controller".classify
        
          resources.find { |object| object.path == controller_class }
        end
      end

      # The following implementation is dervied from Rails::Applicaiton::RouteWrapper
      def verb(route)
        route.verb.source.gsub(/[$^]/, '')
      end

      def path(route)
        route.path.spec.to_s
      end
    end
  end
end