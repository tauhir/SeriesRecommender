require 'Request'
require 'ApiConnection'
class SeriesList < ApplicationRecord
	#should have a method here to return series info for each series in external_series object
	BASE = 'https://api.themoviedb.org/3/tv/'

	def get_series(id)
		
		api_response = Request.get_json('https://api.themoviedb.org/3/tv/',id)
		api_results = api_response[0]
		raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200
		api_results
	end

	def get_list
		self.external_series
	end

	def get_genres(series)
		genres_list = series['genres']
		str = []
		genres_list.each do |genre|
			str.append(genre['name'])
		end
		str.join(', ')
	end
end
