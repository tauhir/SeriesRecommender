require 'test_helper'

class SeriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @series = series(:one)
  end

  test "should get index" do
    get series_index_url
    assert_response :success
  end

  test "should get new" do
    get new_series_url
    assert_response :success
  end

  test "should create series" do
    assert_difference('Series.count') do
      post series_index_url, params: { series: { api_id,: @series.api_id,, name,language,origin_country: @series.name,language,origin_country } }
    end

    assert_redirected_to series_url(Series.last)
  end

  test "should show series" do
    get series_url(@series)
    assert_response :success
  end

  test "should get edit" do
    get edit_series_url(@series)
    assert_response :success
  end

  test "should update series" do
    patch series_url(@series), params: { series: { api_id,: @series.api_id,, name,language,origin_country: @series.name,language,origin_country } }
    assert_redirected_to series_url(@series)
  end

  test "should destroy series" do
    assert_difference('Series.count', -1) do
      delete series_url(@series)
    end

    assert_redirected_to series_index_url
  end
end
