require 'Request'

class Search < ApplicationRecord
	# need to update this to be able to search next page and add to list. might need to add current page attrib?
	attr_accessor :query, :results, :pages
	BASE = 'https://api.themoviedb.org/3/search/tv'
	before_save complete_search

	private 
	def complete_search
		# do the actual api query here. then create series and finish query info
		query = Request.get_json(BASE,params)
		# get amount of 
		@results = query["total_results"]
		@pages = query["total_pages"]
		if results > 0
			series = query["results"] #array of series hashes]
			series_ids = []
			series.each do { |show|
				series_ids.push( show['id'] )
			}
			Series_lists.create(:language => "en_US", :is_search => true, :external_series => series_ids)
		end
		else
			#tell user to do new search
		end

  	end
end
