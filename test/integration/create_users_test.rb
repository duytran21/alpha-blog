require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest

	test "get new user form and create user" do
		get new_user_path
		assert_template 'users/new'
		assert_difference 'User.count', 1 do
			post users_path, params: {user: {username: "alex", email: "alex@example.com", password: "password"}}
			follow_redirect!
		end
		assert_template 'users/show'
		assert_match 'alex', response.body
		
	end

end