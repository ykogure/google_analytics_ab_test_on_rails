class WelcomeController < ApplicationController
  def index
    ab_test_start(:aaa)
  end
end
