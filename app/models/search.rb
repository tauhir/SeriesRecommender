class Search < ApplicationRecord
	attr_accessor :query
	BASE_REQUEST = 'https://api.themoviedb.org/3/search/tv'

	def initialise(args)
		 self.query = Request.getJson(args)
		 # check for error, if not send results back and allow user to select
	end

end
