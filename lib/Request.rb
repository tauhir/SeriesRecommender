class Request
  class << self
    def where(resource_path, query = {}, options = {})
      response, status = get_json(resource_path, query)
      status == 200 ? response : errors(response)
    end

    def get(id)
      response, status = get_json(id)
      raise Exception.new("status: " + status.to_s) if status != 200
      [response,status]
    end

    def errors(response)
      error = { errors: { status: response["status"], message: response["message"] } }
      response.merge(error)
    end

    # Returns JSON response for given path and query
    #
    # @param query_path [string] query path to be added to base 
    # @param query [hash] hash with key value pairs e.g {'request':'Harry Potter'}
    # @return array with Hash and response
    def get_json(query_path, query)
      #query_string = query.map{|k,v| "#{k}=#{URI.encode(v)}"}.join("&")
      # path = query.empty?? root_path : "#{root_path}?#{query_string}" #might need to move this to #Request
      puts 'getjson'
      puts query
      #byebug
      if query.is_a?(Hash)
        response = api.get(query_path) do |req|
          query.each {|k,v| req.params[k] = v }
        end
      else
        response = api.get(query_path)
      end
      [JSON.parse(response.body), response.status]
    end

    def api
      ApiConnection.api
    end
  end
end
