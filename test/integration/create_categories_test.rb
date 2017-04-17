require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

	test "get new category form and create category" do
		get new_category_path
		assert_template 'categories/new'
		assert_difference 'Category.count', 1 do
			#post_via_redirect categories_path, category: {name: "sports"} #in rails 5.1
			#post_via_redirect is deprecated. Use follow_redirect! for replacement.
			post categories_path, params: { category: {name: "sports"} }
			follow_redirect! 
		end
		assert_template 'categories/index'
		assert_match "sports", response.body
	end

	test "invalid category submission results in failure" do
		get new_category_path
		assert_template 'categories/new'
		assert_no_difference 'Category.count' do
			#post_via_redirect categories_path, category: {name: "sports"} #in rails 5.1
			#post_via_redirect is deprecated. Use follow_redirect! for replacement.
			post categories_path, params: { category: {name: " "} }
			
		end
		assert_template 'categories/new'
		#These command will look up in shared/error file 
		assert_select 'h2.panel-title'
		assert_select 'div.panel-body'
	end

end