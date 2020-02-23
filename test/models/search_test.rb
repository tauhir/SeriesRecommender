require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "ActualSearch" do
  	# check that search is done and that serieslist is created with expected id included.
  	search = Search.create({'query':'game of thrones'}) #&language=en-US&query=game%20of%20thrones
  	list = SeriesList.where( search_id: search.id).order(:created_at).first
  	puts list
  	puts list['external_series']
  	assert list['external_series'].include? '1399'
  end
end
