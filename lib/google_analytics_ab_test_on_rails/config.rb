module GoogleAnalyticsAbTestOnRails
  class Config
    # Variables detail is writen in lib/generators/templates/gtm_on_rails.rb.
    attr_accessor :sender
    attr_accessor :tracking_event_category
    attr_accessor :tracking_event_action
    attr_accessor :tracking_event_label
  end
end
