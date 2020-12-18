Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # items
  namespace :api do
    namespace :v1 do
      # find routes
      get '/merchants/find', to: 'merchants/search#find'
      get '/items/find', to: 'items/search#find'
      get '/merchants/find_all', to: 'merchants/search#find_all'
      get '/items/find_all', to: 'items/search#find_all'

      # biz intel routes
      get '/merchants/most_revenue', to: 'business#most_revenue'
      get '/merchants/most_items', to: 'business#most_items'
      get '/merchants/:id/revenue', to: 'business#revenue'
      get '/revenue', to: 'business#revenue_across_dates'

      # relational routes
      get '/merchants/:id/items', to: 'merchants/items#index'
      get '/items/:id/merchants', to: 'items/merchants#show'

      # RESTful routes
      resources :merchants
      resources :items
    end
  end
end
