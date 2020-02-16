require 'test_helper'

class Admin::EntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get candidate_list" do
    get admin_entries_candidate_list_url
    assert_response :success
  end

  test "should get candidate_show" do
    get admin_entries_candidate_show_url
    assert_response :success
  end

end
