require 'test_helper'

class FavouritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get favourites_index_url
    assert_response :success
  end

  test "should get create" do
    get favourites_create_url
    assert_response :success
  end

  test "should get update" do
    get favourites_update_url
    assert_response :success
  end

end
