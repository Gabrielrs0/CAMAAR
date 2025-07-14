require "test_helper"

class Admin::FormsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_forms_index_url
    assert_response :success
  end
end
