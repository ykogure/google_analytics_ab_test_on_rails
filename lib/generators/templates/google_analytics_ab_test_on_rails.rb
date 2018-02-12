GoogleAnalyticsAbTestOnRails.configure do |config|
  # Settings that use Google Tag Manager or analytics.js when send events Google Analytics.
  config.sender = :gtm # :gtm or :analytics_js

  # Google Analytics Tracking Event Settings
  # Event Category is "#{controller_path}##{action_name}" if set nil.
  config.tracking_event_category = nil
  config.tracking_event_action   = 'ab_test'
  config.tracking_event_label    = 'ABテスト_{ab_test_name}-{ab_test_value}'
end
