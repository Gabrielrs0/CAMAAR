require "test_helper"

class Admin::FormsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
<<<<<<< HEAD
    get admin_forms_url
    assert_response :redirect
=======
    get admin_forms_index_url
    assert_response :success
>>>>>>> fa8b901 (merge parte weldo)
  end
end
