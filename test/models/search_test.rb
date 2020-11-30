require "test_helper"

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "ActualSearch" do
    # check that search is done and that serieslist is created with expected id included.
    search = Search.create({'current_query': "game of thrones"}) # &language=en-US&query=game%20of%20thrones
    list = SeriesList.where(search_id: search.id).order(:created_at).first
    assert list["external_series"].include? "1399"
  end

  test "add to query_list" do
    search = Search.create({'current_query': "How I"})
    assert search.query_list == ["How I"]
    search.new_query({'current_query': "friends"})

    assert(search.query_list == ["How I", "friends"], "Did not append new query: #{search.query_list}")
  end

  test "getrecommended" do
    # issue with this is that I can't presume the outcome and compare because of new tv shows so we'll test if it works
    search = Search.create({'current_query': "How I"})
    serieslist = search.get_series.get_list
    search.create_series_list([1668, 1100, 4556, 2691], list_type: "liked")
    search.create_series_list(serieslist[4, 6], list_type: "disliked")
    search.get_recommended
  end

  test "remove_from_recommended" do
    # issue with this is that I can't presume the outcome and compare because of new tv shows so we'll test if it works
    search = Search.create({'current_query': "How I"})
    serieslist = search.get_series.get_list
    search.create_series_list([1668, 1100, 4556, 2691], list_type: "liked")
    search.create_series_list([4250], list_type: "disliked")
    orig_recommends = search.get_recommended.get_list
    show_to_remove = orig_recommends[10]
    search.get_disliked.append(show_to_remove)
    new_recommends = search.get_recommended.get_list
    assert((search.get_recommended.get_list.include? show_to_remove) == false, "Did not remove disliked show from recommends")
  end
end
