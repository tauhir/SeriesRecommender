Rails.application.routes.draw do
  resources :series_lists
  resources :series
  get 'home/new'
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
