require 'test_helper'

class FeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get feeds_index_url
    assert_response :success
  end

  test "should get show" do
    get feeds_show_url
    assert_response :success
  end

  test "should get company_feed" do
    get feeds_company_feed_url
    assert_response :success
  end

end
