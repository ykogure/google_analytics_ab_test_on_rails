module GoogleAnalyticsAbTestOnRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a GoogleAnalytics A/B Test on Rails initializer to your application."

      def copy_initializer
        template "google_analytics_ab_test_on_rails.rb", "config/initializers/google_analytics_ab_test_on_rails.rb"
      end

      # def insert_javascript_tag
      #   inject_into_file "app/views/layouts/application.html.erb", after: /<head[\s]?[^>]*>/ do
      #     "\n    <%= render_gtm_on_rails_tag_in_head %>\n"
      #   end
      #   inject_into_file "app/views/layouts/application.html.erb", after: /<body[\s]?[^>]*>/ do
      #     "\n    <%= render_gtm_on_rails_tag_in_body %>\n"
      #   end
      # end
    end
  end
end
