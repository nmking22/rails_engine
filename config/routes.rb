Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # items
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#find'
      get '/items/find', to: 'items/search#find'
      get '/merchants/find_all', to: 'merchants/search#find_all'
      get '/items/find_all', to: 'items/search#find_all'
      get '/merchants/most_revenue', to: 'merchants/search#most_revenue'
      get '/merchants/most_items', to: 'merchants/search#most_items'
      get '/merchants/:id/items', to: 'merchants/items#index'
      get '/items/:id/merchants', to: 'items/merchants#show'
      resources :merchants
      resources :items
    end
  end
end
