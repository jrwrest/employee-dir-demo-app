require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
    def setup
        sign_out users(:two)
        user_one
    end



test "admin should add a new user" do
    user_one
    visit root_path
    click_button "New"
    create_update_user("Add Employee","new1@example.com", "new1", "Im new here", "Submit")
    assert_text "Saved..."

end

test "admin should edit another user" do
    user_one
    visit root_path
    first("svg.feather-edit-3").click
    create_update_user("Edit Employee","demo1@example.com", "demo1", "Im new here and this is a demo", "Update")
    assert_text "Updated..."
end

test "admin should delete a user" do
    
    user_one
    visit root_path
    first("svg.bi-trash").click
    assert_text "User Deleted..."
    
end

test "admin should not create an invalid user" do
    user_one
    visit new_user_path
    create_update_user("Add Employee","one@gmail.com", "fail", "Im new here", "Submit")
    assert_text "Email has already been taken"
    
end

def user_one
    sign_in users(:one)
end

end