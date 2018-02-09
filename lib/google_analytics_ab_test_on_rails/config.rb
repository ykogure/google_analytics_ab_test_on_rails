module GoogleAnalyticsAbTestOnRails
  class Config
    # Variables detail is writen in lib/generators/templates/gtm_on_rails.rb.
    attr_accessor :sender
    attr_accessor :gtm_container_id
    attr_accessor :analytics_tracking_id
  end
end
