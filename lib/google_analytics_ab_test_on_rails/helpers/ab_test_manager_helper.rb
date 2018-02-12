module GoogleAnalyticsAbTestOnRails
  module Helpers
    module AbTestManagerHelper
      def render_ab_test_manager
        tags = []
        tags << render(partial: 'google_analytics_ab_test_on_rails/ab_test_manager')
        tags.join.html_safe
      end

      def render_ab_test_analytics_js
        "<script type=\"text/javascript\">#{(@analytics_js_codes || []).join}</script>".html_safe
      end
    end
  end
end
