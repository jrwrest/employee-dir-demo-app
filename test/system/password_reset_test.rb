require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
    include Capybara::Email::DSL
    include ActiveJob::TestHelper
  
   



test "user can reset their password" do
    sign_out users(:two)
    sign_out users(:one)
    @user = users(:one)
    perform_enqueued_jobs do
        visit root_path
        assert page.current_path == new_user_session_path
        click_link "Forgot your password?"

        assert page.current_path == new_user_password_path
        assert_selector "h1", text: "Password Reset"
        fill_in "user_email", with: @user.email
        click_button "Send me reset password instructions"

        assert_text "You will receive an email with instructions on how to reset your password in a few minutes."
    end
    open_email(@user.email)
    assert_content(current_email, "Hello one@gmail.com! Someone has requested a link to change your password. You can do this through the link below. Change my password If you didn't request this, please ignore this email. Your password won't change until you access the link above and create a new one.")
    current_email.click_link('Change my password')

    assert page.has_content? 'Change your password' 
    fill_in 'New password', with: '123456'
    fill_in 'Confirm new password', with: '123456'
    click_on 'Change my password'
    assert page.has_content? 'Your password has been changed successfully. You are now signed in.' 
  end
 

end
