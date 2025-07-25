require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
<<<<<<< HEAD
    get root_url
=======
    get home_index_url
>>>>>>> fa8b901 (merge parte weldo)
    assert_response :success
  end
end
