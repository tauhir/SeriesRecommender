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
		SeriesList.where(search_id: self.id).last
	end
	
	def create_series_list(ext_series, language:"en_US",search_id: self.id, search_type: nil)
		# @todo can probably remove search_id param then use self.id
		SeriesList.create(:language => language, :external_series => ext_series, :search_id => search_id, :search_type => search_type)
	end

	def new_query(query)
		self.current_query = query[:current_query]
		self.save
	end

	def get_recommended
		# Should get all recommended for each liked and then list by most occured. 
		# For now we're not taking into account the following:
		# genre, origin country, age, actors.

		# The general idea here is the following:
		# 	have two arrays, one to iterate through and one 2d array with each recommends list
		# 	From the iterating array, we need to remove the duplicates and disliked shows
		# 	We can then iterate through the array and look for a show in the 2d array
		# 	wherever we find a 2d array we can determine the position of the total like
		# 	We can add this up for each list and divide by the total to get the recommended (1 - result because lowest is higher here) like below:
		# 		 1 - (pos1/total1 + pos2/total2 + pos3/total3 ...)/total lists to get liked percentage 
		# 		in above, if value is not in a list use 1.1 as its worse than being last (arb number lol ) @todo get better way then 1.1
		# 	The results can be made into a hash or something and will determine order
		# 	This will update whenever a user likes/dislikes something
		return nil if !self.get_liked #should display a section telling users to start liking to get started
		liked = self.get_liked.get_list
		disliked = self.get_disliked.get_list
		
		recommends = []		#going to be the 2d array
		
		liked.each do |series|

			recommends.append( get_recommended_series(series) )
		end
		iterating_array = recommends.flatten # to make a single array to iterate through
		iterating_array = iterating_array.uniq # remove duplicates
		iterating_array = iterating_array.map { |val| val if disliked.exclude? (val)} 
		recommends_results = {}
		iterating_array.each do |series|
			# for each series, we want to iterate through all the lists and find the total
			value = 0
			(0..recommends.size).each do |index|
				# check for position in list
				if recommends[index]	
					pos = recommends[index].index(series) # returns nil if not in array
					size = recommends[index].size.to_f # forcing float division for required float in value ternary statement below
					# puts "pos: " + pos.to_s
					# puts "size: " + size.to_s
					value += pos ? pos/size : 1.1 # pos evaluates to true if its a number
					# puts "val: " + value.to_s
				end
			end
			percentage = (1 - value/recommends.size)*100 # anything less than zero should be excluded
			recommends_results[series] =( percentage > 0 ? percentage : nil )
		end
		recommends_results = recommends_results.compact.sort_by {|k, v| -v}.to_h # removes all keys with nil values, then sorts by descending values - best show first 
		# after completetion let user add to like, then we can run this again as they change their likes
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
				raise Exception.new("no search results found")
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
