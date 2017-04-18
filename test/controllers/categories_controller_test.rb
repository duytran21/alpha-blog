require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
	def setup

		@category = Category.create(name: "sports")
		@user  = User.create(username: "tom", email: "tom@example.com", password: "password", admin: true)

	end
	test "should get index" do 
		get :index
		assert_response :success
	end

	test "should get new" do
		session[:user_id] = @user.id
		get :new
		assert_response :success
	end

	test "should get show" do
		#get(:show, {'id' => @category.id}) # this style is deprecated in rails 5.1
		get :show, params: {'id' => @category.id}
		assert_response :success
	end

	test "should redirect create when admin not log in" do
		assert_no_difference 'Category.count' do
			post :create, params: {category: {name: 'sports'}}
		end
		assert_redirected_to categories_path

	end
end