require 'google_analytics_ab_test_on_rails/config'
require 'google_analytics_ab_test_on_rails/controllers/ab_test_methods'
require 'google_analytics_ab_test_on_rails/helpers/ab_test_manager_helper'

module GoogleAnalyticsAbTestOnRails
  def self.config
    @config ||= GoogleAnalyticsAbTestOnRails::Config.new
  end
 
  def self.configure(&block)
    yield(config) if block_given?
  end
  
  class Engine < ::Rails::Engine
    isolate_namespace GoogleAnalyticsAbTestOnRails

    initializer 'gtm_on_rails.action_controller_extension' do
      ActiveSupport.on_load :action_controller do
        include GoogleAnalyticsAbTestOnRails::Controllers::AbTestMethods
      end
    end

    initializer 'gtm_on_rails.action_view_helpers' do
      ActiveSupport.on_load :action_view do
        include GoogleAnalyticsAbTestOnRails::Helpers::AbTestManagerHelper
      end
    end
  end
end
