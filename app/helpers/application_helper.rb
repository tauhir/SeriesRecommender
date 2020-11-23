module ApplicationHelper

    def has_search
        session[:current_search_id] != nil
    end
    
    def has_recommended
      true if @search && @search.get_recommended
    end
end
