module GoogleAnalyticsAbTestOnRails
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates/views", __FILE__)

      argument :type, required: false, default: nil

      public_task :copy_views

      desc "Creates a GoogleAnalytics A/B Test on Rails initializer to your application."

      def copy_views
        case type
        when 'bootstrap3'

        when 'position_under'
          copy_file "ab_test_manager/position_under.html.erb", "app/views/google_analytics_ab_test_on_rails/_ab_test_manager.html.erb"
        when 'position_top'
          copy_file "ab_test_manager/position_top.html.erb", "app/views/google_analytics_ab_test_on_rails/_ab_test_manager.html.erb"
        when nil
          copy_file "ab_test_manager/position_top.html.erb", "app/views/google_analytics_ab_test_on_rails/_ab_test_manager.html.erb"
        else
          raise NameError.new("'#{type}' is undefined template type.")
        end
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
