require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "ActualSearch" do
  	# check that search is done and that serieslist is created with expected id included.
  	search = Search.create({'current_query':'game of thrones'}) #&language=en-US&query=game%20of%20thrones
	list = SeriesList.where( search_id: search.id).order(:created_at).first
  	assert list['external_series'].include? '1399'
  end

  test 'add to query_list' do
	search = Search.create({'current_query':'How I'})
	assert search.query_list == ['How I']
	search.new_query('friends')
	
	assert( search.query_list == ['How I', 'friends'], "Did not append new query: #{search.query_list}")
  end

  test 'getrecommended' do
	# issue with this is that I can't presume the outcome and compare because of new tv shows so we'll test if it works
	search = Search.create({'current_query':'How I'})
	serieslist = search.get_series
	search.create_series_list(serieslist.getlist[0],search_id: search.id, search_type: true)
	search.get_recommended
  end
end
