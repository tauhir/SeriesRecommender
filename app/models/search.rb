require 'Request'
require 'ApiConnection'

class Search < ApplicationRecord
	# @todo need to update this to be able to search next page and add to list. might need to add current page attrib?
	# attr_accessor :query, :results, :pages
	attr_accessor :external_series
	has_many :SeriesList
	SEARCH_BASE = 'https://api.themoviedb.org/3/search/tv'
	SIMILAR_BASE = 'https://api.themoviedb.org/3/tv/'
	before_save :complete_search
	after_save :post_search

	def get_series # maybe just the i
		SeriesList.where(search_id: self.id).first
	end
	
	def create_series_list(ext_series, language:"en_US",search_id: self.id, search_type: nil)
		# @todo can probably remove search_id param then use self.id
		SeriesList.create(:language => language, :external_series => ext_series, :search_id => search_id, :search_type => search_type)
	end

	def new_query(query)
		self.current_query = query
		self.save
	end

	def get_recommended
		# @todo, not sure yet tbh. Need to build a recommended list from
		# liked lists. Should get all recommended for each liked and then list by most occured
		# there's a bunch of arbitary things I can think of to best recommend like:
		# genre, origin country, age, actors. I'll need to look into this @
		# now do a loop getting all series that are recommended
		liked = self.get_liked.get_list
		recommends = []
		liked.each do |series|
			recommends.append( get_recommended_series(series) )
		end
		# next order them by most commonly occured and let user add to like, then we can run this again 
		# it makes sense to do the following
		# make array of all series to iterate through and remove duplicates
		# remove disliked occurences from iterating array @todo allow them to include disliked 

		# get size of each shows recommends and for each show:
		# determine the position and do pos/total
		# do 1 - (pos1/total1 + pos2/total2 + pos3/total3 ...)/total lists to get liked percentage 
		# in above, if value not in list use 1.1 as its worse than being last (arb number lol)
		# highest to lowest of the results will be recommendations. If negative, lets remove

		
	end

	def get_liked
		SeriesList.where(search_type: true).find_by(search_id: self.id)
	end

	def get_disliked
		SeriesList.where(search_type: false).find_by(search_id: self.id)
	end
	
 	private

 	# takes query parameter and calls API to do search. Creates SeriesList object
 	# rewrites results and pages as they'll always be releted to current_query
		def complete_search
			# do the actual api query here. then create series and finish query info
			# puts query
			# creating the hash here for now. Might make additional param to Request.rb if not DRY
			query_hash = {'query': self.current_query}
			api_response = Request.get_json(SEARCH_BASE,query_hash)
			@api_results = api_response[0]
			raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200
			self.results = @api_results["total_results"] 
			self.pages = @api_results["total_pages"]
			self.query_list.append(self.current_query)
			#self.save		
		end
		
		def post_search 
			if self.results > 0
				series = @api_results["results"] # array of series hashes
				series_ids = []
				series.each { |show| series_ids.push( show['id'] ) }
				create_series_list(series_ids)
			else
				puts "wow"
				# @todo no results
			end
		end

		# actual get series
		def get_recommended_series(seriesId)
			url = SIMILAR_BASE + "#{seriesId}/similar"
			results = []
			(1..4).each do |page| # @todo currently gets first 3 pages but we're presuming there are 3

				query_hash = {'page': page}
				api_response = Request.get_json(url,query_hash) # @todo update get_json to variable params
				raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200
				api_results = api_response[0]["results"]
				result_ids = []
				api_results.each do |result|
					results.append(result["id"])
				end
			end
			results
		end

end
