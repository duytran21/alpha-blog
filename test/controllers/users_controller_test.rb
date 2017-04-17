require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def sign_in(user)
    post login_path, params: {email: user.email, password: user.password}
    follow_redirect!
  end
  setup do
    #@user = User.new(username: "john", email: "john@example.com", password: "password", admin: true)
    @user = User.create(username: "jack", email: "jack@example.com", password: "password", admin: true)  
    #session[:user_id] = @user.id
    #current_user 
    #@user.confirmed_at: Time.now
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, username: @user.username, password: @user.password} }
    end

    assert_redirected_to user_url(User.last)
    #assert_redirected_to users_path
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user), params: { session: {user_id: @user.id}}
    #sign_in(@user)
    #get edit_user_url(@user)
    assert_response :success
  end

  test "should update user"  do
    #session[:user_id] = @user1.id
    patch user_url(@user), params: { user: { email: @user.email, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
