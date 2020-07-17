require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search = searches(:one)
  end

  # test "should get index" do
  #   get searches_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_search_url
  #   assert_response :success
  # end

  # test "should create search" do
  #   assert_difference('Search.count') do
  #     post searches_url, params: { search: {  } }
  #   end

  #   assert_redirected_to search_url(Search.last)
  # end

  # test "should show search" do
  #   get search_url(@search)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_search_url(@search)
  #   assert_response :success
  # end

  test "should update search" do
    list = @search.query_list
    patch search_url(@search), params: { "query" => "mother" }
    list.append("mother")
    assert( @search.query_list == list, "query_list not matching expected result #{list}")
    assert_redirected_to search_url(@search)
  end

  test "should destroy search" do
    assert_difference('Search.count', -1) do
      delete search_url(@search)
    end

    assert_redirected_to searches_url
  end

  test "user gave opinion" do
    self.setup
    post opinion_url, params: { "seriesId": '0001', "liked": true, "searchId":2 }
    @series_list = SeriesList.where(list_type: "liked").find_by(search_id: @search.id)
    assert @series_list.try(:external_series).try(:include?, '0001')

    #checks if appending works
    post opinion_url, params: { "seriesId": '0002', "liked": true, "searchId":2 }
    @series_list = SeriesList.where(list_type: "liked").find_by(search_id: @search.id)
    assert @series_list.try(:external_series), ["0001","0002"]

    post opinion_url, params: { "seriesId": '0003', "liked": false, "searchId":2 }
    @series_list = SeriesList.where(list_type: "disliked").find_by(search_id: @search.id)
    assert @series_list.try(:external_series), ["0003"]

    post opinion_url, params: { "seriesId": '0004', "liked": false, "searchId":2 }
    @series_list = SeriesList.where(list_type: "disliked").find_by(search_id: @search.id)
    assert @series_list.try(:external_series), ["0003","0004"]
  end

  test 'get liked series_list' do
    @search = Search.create({'current_query':'How I'})
    post opinion_url, params: { "seriesId": '0001', "liked": true, "searchId": @search.id }
    liked_list = SeriesList.where(list_type: "liked").find_by(search_id: @search.id)
    assert( @search.get_liked == liked_list, "liked list doesn't match" )
  end

  test 'get disliked series_list' do #not sure if we need this method
    @search = Search.create({'current_query':'How I'})
    post opinion_url, params: { "seriesId": '0001', "liked": false, "searchId": @search.id }
    disliked_list = SeriesList.where(list_type: "disliked").find_by(search_id: @search.id)
    assert( @search.get_disliked == disliked_list, "disliked list doesn't match" )
  end
end
