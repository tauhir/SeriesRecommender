module ApplicationHelper

    def has_search
        session[:current_search_id] != nil
    end 
end
