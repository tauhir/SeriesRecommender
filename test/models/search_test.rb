require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "ActualSearch" do
  	# check that search is done and that serieslist is created with expected id included.
  	search = Search.new({'query':'game of thrones'}) #&language=en-US&query=game%20of%20thrones
  	assert search['id'] == 1399
end
