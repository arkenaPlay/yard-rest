module YARD::Rest
  class Config
    class << self
      def root
        @heroku_rails_root || ENV["RAILS_ROOT"] || "."
      end

      def root=(root)
        @heroku_rails_root = root
      end
    end
  end
end