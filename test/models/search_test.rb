require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "ActualSearch" do
  	search = Search.new('Game of Thrones') #&language=en-US&query=game%20of%20thrones
end
