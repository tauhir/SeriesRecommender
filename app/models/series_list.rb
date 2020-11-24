require 'Request'
require 'ApiConnection'
class SeriesList < ApplicationRecord
	enum list_type: [
		:liked,
		:disliked,
		:search,
		:recommended
	]
	#should have a method here to return series info for each series in external_series object
	BASE = 'https://api.themoviedb.org/3/tv/'
	

	def get_series(id)
		
		api_response 	= Request.get_json('https://api.themoviedb.org/3/tv/',id.to_s)
		seriesInfo 		= api_response[0]
		raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200
		
		api_response 	= Request.get_json('https://api.themoviedb.org/3/tv/',(id.to_s+"/credits"))
		creditsInfo 	= api_response[0]
		raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200
		
		query_hash		= {'include_image_language': 'en'}
		query_path		= 'https://api.themoviedb.org/3/tv/' + id.to_s + "/images"
		api_response	= Request.get_json(query_path, query_hash)
		raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200

		images = []
		api_response[0]["posters"].each do |x| images.append( x["file_path"] ) end
		
		seriesInfo["images"]	= images[0,4]
		seriesInfo["cast"]		= creditsInfo["cast"]
		seriesInfo
	end

	def get_list
		self.external_series
	end

	def get_genres(series,amount)
		genres_list		= series['genres']
		str			 	= []
		amount 			= genres_list.length <= amount ? genres_list.length : amount
		genres_list[ 0..amount ].each do |genre|
			str.append( genre['name'] )
		end
		str.join(', ')
	end

	def append(series_to_add)
		self.external_series.append(series_to_add)
		self.save
	end

	# this could be dangerous to the list because it replaces everything
	def set_series(series_to_add)
		self.external_series = series_to_add
		self.save
	end
end
