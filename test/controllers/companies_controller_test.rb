require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get companies_top_url
    assert_response :success
  end

  test "should get about" do
    get companies_about_url
    assert_response :success
  end

  test "should get member" do
    get companies_member_url
    assert_response :success
  end

  test "should get show" do
    get companies_show_url
    assert_response :success
  end

  test "should get edit" do
    get companies_edit_url
    assert_response :success
  end

end
