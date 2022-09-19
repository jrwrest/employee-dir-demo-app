require "test_helper"

class MobileSystemTestCase < ActionDispatch::SystemTestCase
    # config.before(:each, type: :system, js: true) do
    #     driven_by ENV['SELENIUM_DRIVER'].to_sym
    #   end

    driven_by :selenium, using: :chrome, screen_size: [375, 667]

end