require 'Request'
require 'ApiConnection'

class Search < ApplicationRecord
	# @todo need to update this to be able to search next page and add to list. might need to add current page attrib?
	# attr_accessor :query, :results, :pages
	has_many :SeriesList
	BASE = 'https://api.themoviedb.org/3/search/tv'
	after_create :complete_search
 	
 	private

 	# takes query parameter and calls API to do search. Creates SeriesList object
 	# 
	def complete_search
		# do the actual api query here. then create series and finish query info
		#puts query
		 # creating the hash here for now. Might make additional param to Request.rb if not DRY
		query_hash = {'query': self.query}
		api_response = Request.get_json(BASE,query_hash)
		api_results = api_response[0]
		raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200
		#puts api_results["total_results"]
		self.results = api_results["total_results"]
		self.pages = api_results["total_pages"]
		self.save
		# self.results = api_results["total_results"]
		# self.pages = api_results["total_pages"]
		
		if self.results > 0
			puts self.results
			series = api_results["results"] # array of series hashes
			series_ids = []
			series.each { |show| series_ids.push( show['id'] ) }
			puts self.id
			SeriesList.create(:language => "en_US", :external_series => series_ids, :search_id => self.id)
			puts "here now"
		else
			puts "wow"
			# @todo no results
		end
  	end
end
