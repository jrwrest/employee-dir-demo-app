ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"
require "rails/test_help"



class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
 
  Capybara.server_port = 3001
  Capybara.app_host = 'http://localhost:3001'
  

  def create_update_user(heading = "Sign Up", email = "email@email.com", name = "email",
                             bio = "demo data", button = "Submit")
    assert_selector "h2", text: heading
    fill_in "user_email", with: email
    fill_in "user_name", with: name
    fill_in "user_bio", with: bio    
    if has_css?("svg#cam") 
        page.attach_file('app/assets/images/new_person.jpg') do
            page.find(:css, "svg#cam").click
        end
    else    
        attach_file('user_avatar', 'app/assets/images/new_person.jpg')
    end
    fill_in "user_password", with: 123456 if has_css?("#user_password") 
    fill_in "user_password_confirmation", with: 123456 if has_css?("#user_password_confirmation") 
    fill_in "user_current_password", with: 123456 if has_css?("#user_current_password") 
    click_button button
end



end

