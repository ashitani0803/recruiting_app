require 'test_helper'

class Admin::CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_companies_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_companies_edit_url
    assert_response :success
  end

end
