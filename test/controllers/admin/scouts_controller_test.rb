require 'test_helper'

class Admin::ScoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get admin_scouts_search_url
    assert_response :success
  end

end
