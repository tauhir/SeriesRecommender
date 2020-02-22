require 'test_helper'

class SeriesListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @series_list = series_lists(:one)
  end

  test "should get index" do
    get series_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_series_list_url
    assert_response :success
  end

  test "should create series_list" do
    assert_difference('SeriesList.count') do
      post series_lists_url, params: { series_list: { api_id,: @series_list.api_id,, name,language,origin_country: @series_list.name,language,origin_country } }
    end

    assert_redirected_to series_list_url(SeriesList.last)
  end

  test "should show series_list" do
    get series_list_url(@series_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_series_list_url(@series_list)
    assert_response :success
  end

  test "should update series_list" do
    patch series_list_url(@series_list), params: { series_list: { api_id,: @series_list.api_id,, name,language,origin_country: @series_list.name,language,origin_country } }
    assert_redirected_to series_list_url(@series_list)
  end

  test "should destroy series_list" do
    assert_difference('SeriesList.count', -1) do
      delete series_list_url(@series_list)
    end

    assert_redirected_to series_lists_url
  end
end
