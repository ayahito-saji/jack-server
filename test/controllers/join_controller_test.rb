require 'test_helper'

class JoinControllerTest < ActionDispatch::IntegrationTest
  test "should get join" do
    get join_join_url
    assert_response :success
  end

end
