require 'test_helper'
# ActionController::TestCase is deprecated in Rails 5
class UsersControllerTest < ActionController::TestCase
  #def sign_in(user)
  #  post login_path, params: {email: user.email, password: user.password}
  #  follow_redirect!
  #end
  setup do
    #@user = User.new(username: "john", email: "john@example.com", password: "password", admin: true)
    @user = User.create(username: "jack", email: "jack@example.com", password: "password", admin: true)  
    #session[:user_id] = @user.id
    #current_user 
    #@user.confirmed_at: Time.now
    @user1 = User.new(username: "jay", email: "jay@example.com", password: "password", admin: false)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, params: { user: { email: @user1.email, username: @user1.username, password: @user1.password} }
    end

    assert_redirected_to user_path(User.last)
    #assert_redirected_to users_path
  end

  test "should show user" do
    get :show, params: {id: @user.id}
    assert_response :success
  end

  test "should get edit" do
    session[:user_id] = @user.id
    get :edit, params: {id: @user.id}
    #sign_in(@user)
    #get edit_user_url(@user)
    assert_response :success
  end

  test "should update user"  do
    #session[:user_id] = @user1.id
    updated_email = "updatedemail@example.com"
    updated_username = "updatedusername"
    #put :update, params: {user: {id: @user.id, email: updated_email, username: updated_username, password: @user.password}}
    patch :update, params: {id: @user.id, user: {email: updated_email, username: updated_username}}
    #assert_redirected_to user_path(@user)
    @user.reload
    assert_equal updated_username, @user.username
    assert_equal updated_email, @user.email
   # assert_redirected_to 
  end

  test "should destroy user" do
    session[:user_id] = @user.id
    assert_difference('User.count', -1) do
      delete :destroy, params: {id: @user.id}
    end

    assert_redirected_to users_path
  end
end
