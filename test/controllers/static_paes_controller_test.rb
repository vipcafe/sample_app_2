require "test_helper"

class StaticPaesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_paes_home_url
    assert_response :success
  end

  test "should get help" do
    get static_paes_help_url
    assert_response :success
  end
end
