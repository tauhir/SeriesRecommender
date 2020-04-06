require 'Request'
require 'ApiConnection'

class Search < ApplicationRecord
	# @todo need to update this to be able to search next page and add to list. might need to add current page attrib?
	# attr_accessor :query, :results, :pages
	attr_accessor :external_series
	has_many :SeriesList
	BASE = 'https://api.themoviedb.org/3/search/tv'
	after_create :complete_search

	def get_series # maybe just the i
		SeriesList.where(search_id: self.id).first
	end
	
	def create_series_list(ext_series, language:"en_US",search_id: self.id, search_type: nil)
		# @todo can probably remove search_id param then use self.id
		SeriesList.create(:language => language, :external_series => ext_series, :search_id => search_id, :search_type => search_type)
	end

 	private

 	# takes query parameter and calls API to do search. Creates SeriesList object
 	# 
	def complete_search
		# do the actual api query here. then create series and finish query info
		# puts query
		 # creating the hash here for now. Might make additional param to Request.rb if not DRY
		query_hash = {'query': self.current_query}
		api_response = Request.get_json(BASE,query_hash)
		api_results = api_response[0]
		raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200
		self.results = api_results["total_results"]
		self.pages = api_results["total_pages"]
		self.query_list = [self.current_query]
		self.save		
		if self.results > 0
			series = api_results["results"] # array of series hashes
			series_ids = []
			series.each { |show| series_ids.push( show['id'] ) }
			create_series_list(series_ids)
		else
			puts "wow"
			# @todo no results
		end
  	end
end
