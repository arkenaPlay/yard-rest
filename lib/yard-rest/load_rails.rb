module YARD::Rest
  module LoadRails
    def self.included(base)
      # Ensures that ONLY test database is being used.
      ActiveRecord::Base.establish_connection(:test)

      begin
        # Reload all factories.
        FactoryGirl.factories.clear
        Dir.glob("#{Rails.root}/spec/factories/**/*.rb").each { |file| load "#{file}" }
      rescue FactoryGirl::DuplicateDefinitionError
        # Do nothing.
      end
    end
  end
end