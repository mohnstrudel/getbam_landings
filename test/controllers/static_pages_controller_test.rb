require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get learning" do
    get static_pages_learning_url
    assert_response :success
  end

end
