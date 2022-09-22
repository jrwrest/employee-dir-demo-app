require "mobile_system_test_case"

class MobileTest < MobileSystemTestCase

    def setup
        sign_in users(:two)
        @other_user = users(:three)
    end

test "mobile should be able to search for employees and view show" do
    visit root_path

    assert_text "Employees Found:"
    fill_in "search", with: "one"
    find('#search').native.send_keys(:return)

    within find "#m_employee_dir" do 
        click_on "one"
    end
    assert_selector "h2", text: "A"
end

test "mobile user should not go to new user page" do
    visit new_user_path
    assert_text "Employees Found:"
end

test "mobile user should see admin buttons" do
    visit root_path
    #no add new button
    assert_no_button "Add New"
    #no edit button
    assert_no_css "svg.feather-edit-3"
    #no delete button
    assert_no_css "svg.bi-trash"
end

test "mobile user should no got to another user edit page" do
    visit edit_user_path(@other_user)
    assert_text "Employees Found:"
end


test "mobile create a new user account" do
    sign_out users(:two)
    visit new_user_registration_path
    create_update_user("Sign Up", "new_user@signup.com","Example Name","bio", "Submit")
    assert_text "Welcome! You have signed up successfully."
end

test "mobile user can login" do
    sign_out users(:two)
    visit root_path
    click_button "Log in"
    fill_in "user_email", with: "one@gmail.com"
    fill_in "user_password", with: 123456
    check "user_remember_me"
    click_button "Log in"
    assert_text "Signed in successfully."
end

test "mobile user can edit own profile" do 
    visit edit_user_registration_path
    create_update_user("Edit Profile", "new_user@signup.com","Example Name","bio", "Update")
    assert_text "Your account has been updated successfully."
end

test "mobile user should delete account" do
    visit edit_user_registration_path
    click_button "Cancel my account"
    assert_text "Log in"
end

test "mobile user cant sign in without correct password" do
    sign_out users(:two)
    visit root_path
    fill_in "user_email", with: "one@gmail.com"
    fill_in "user_password", with: 12345667
    click_button "Log in"
    assert_text "Invalid Email or password."
end

test "mobile user can use pagination" do

    visit root_path
    
    assert page.has_content? 'Employees Found:' 
    click_on 'Next →'
    assert_current_path "/?page=2"
    click_on "4"
    assert_current_path "/?page=4"
    click_on "← Previous"
    assert_current_path "/?page=3"
  end

end