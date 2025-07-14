require "test_helper"

class Admin::FormsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_forms_url
    assert_response :redirect
  end
end
