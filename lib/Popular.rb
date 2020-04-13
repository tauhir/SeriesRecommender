require 'Request'
require 'ApiConnection'
class Popular
	#should have a method here to return series info for each series in external_series object
	BASE = 'https://api.themoviedb.org/3/tv/popular'

	def get_popular(page)
		query_hash = {'page': page}
		api_response = Request.get_json(BASE,query_hash)
		api_results = results = api_response[0]["results"] # we could get total results and pages here if we wanted
		raise Exception.new("status: " + api_response[1].to_s) if api_response[1] != 200
		api_results
    end
    
    def get_10_popular_pages()
        results = []
        for i in 0..10
            page = get_popular(i)
            for i in 0..page.size
                results.append(page[i]["id"])
            end
        end
        # we should now create a serieslist with this
        SeriesList.create(:language => "en_US", :external_series => results, :search_id => 1, :search_type => nil) 
    end
end