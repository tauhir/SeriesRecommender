require 'faraday'
require 'json'

class ApiConnection

  BASE = 'https://api.themoviedb.org/3/' #base? this isn't the true base. 

  def self.api
    Faraday.new(url: BASE) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.params['api_key'] = ENV['TMDB_API']
      faraday.params['language'] = 'en-US'
    end
  end
end
