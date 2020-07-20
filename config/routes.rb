Rails.application.routes.draw do
  get 'searches/checks', to: 'searches#has_session', as: 'has_session'
  resources :searches
  post '/searches/opinion', to: 'searches#opinion', as: 'opinion'
  get 'searches/show', to: 'searches#show', as: 'show_search'
  post 'searches/update', to: 'searches#update', as: 'update_search'
  #resources :series_lists
  get '/series_lists/:id', to: 'series_lists#show', as: 'series_list'
  get '/recommended', to: 'searches#recommendations'
  root to: 'series_lists#popular'
  get 'home/new'
  get 'home/index'

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
