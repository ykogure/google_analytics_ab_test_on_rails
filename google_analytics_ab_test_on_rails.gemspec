$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "google_analytics_ab_test_on_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "google_analytics_ab_test_on_rails"
  s.version     = GoogleAnalyticsAbTestOnRails::VERSION
  s.authors     = ["ykogure"]
  s.email       = ["renkin1008@gmail.com"]
  s.homepage    = "https://github.com/ykogure/google_analytics_ab_test_on_rails"
  s.summary     = "This gem enables you to do A/B testing easy with Rails application."
  s.description = "This gem enables you to do A/B testing easy with Rails application."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.0"
end
