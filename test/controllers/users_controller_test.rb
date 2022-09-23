require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user       = users(:one)
    @other_user = users(:two)
  end

  test "should get new" do
    get new_user_session_path
    assert_response :success
  end

 
  test "should redirect index when not logged in" do
    get root_path
    assert_redirected_to user_session_path	
  end

  test "should redirect edit when not logged in" do
    get edit_user_registration_path(@user)
    assert_select "p", "You need to sign in or sign up before continuing."
    end

  test "should redirect update when not logged in" do
    patch user_registration_path(@user), params: { user: { name: @user.name,
                                                  email: @user.email } }
    assert_select "p", "You need to sign in or sign up before continuing."
  end

  test "should redirect edit when logged in as wrong user" do
    login_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    login_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to user_session_path
  end

  test "should redirect destroy when logged in as a non-admin" do
    login_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end

end