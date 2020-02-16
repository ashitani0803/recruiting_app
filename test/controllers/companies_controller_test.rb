require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get companies_home_url
    assert_response :success
  end

  test "should get show" do
    get companies_show_url
    assert_response :success
  end

  test "should get member" do
    get companies_member_url
    assert_response :success
  end

end
