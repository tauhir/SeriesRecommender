Rails.application.routes.draw do
  resources :searches
  #resources :series_lists
  get '/series_lists/:id', to: 'series_lists#show', as: 'series_list'
  root to: 'series_lists#popular'
  get 'home/new'
  get 'home/index'
  post '/searches/opinion', to: 'searches#opinion', as: 'opinion'
  get 'searches/show', to: 'searches#show', as: 'show_search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
