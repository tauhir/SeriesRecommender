json.extract! series_list, :id, :api_id,, :name,language,origin_country, :created_at, :updated_at
json.url series_list_url(series_list, format: :json)
