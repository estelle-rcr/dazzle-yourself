require 'test_helper'

class PackagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get packages_index_url
    assert_response :success
  end

end
