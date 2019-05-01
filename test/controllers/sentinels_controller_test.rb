require 'test_helper'

class SentinelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sentinel = sentinels(:one)
  end

  test "should get index" do
    get sentinels_url
    assert_response :success
  end

  test "should get new" do
    get new_sentinel_url
    assert_response :success
  end

  test "should create sentinel" do
    assert_difference('Sentinel.count') do
      post sentinels_url, params: { sentinel: {  } }
    end

    assert_redirected_to sentinel_url(Sentinel.last)
  end

  test "should show sentinel" do
    get sentinel_url(@sentinel)
    assert_response :success
  end

  test "should get edit" do
    get edit_sentinel_url(@sentinel)
    assert_response :success
  end

  test "should update sentinel" do
    patch sentinel_url(@sentinel), params: { sentinel: {  } }
    assert_redirected_to sentinel_url(@sentinel)
  end

  test "should destroy sentinel" do
    assert_difference('Sentinel.count', -1) do
      delete sentinel_url(@sentinel)
    end

    assert_redirected_to sentinels_url
  end
end
