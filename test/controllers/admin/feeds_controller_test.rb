require 'test_helper'

class Admin::FeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_feeds_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_feeds_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_feeds_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_feeds_edit_url
    assert_response :success
  end

end
