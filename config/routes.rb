Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # items
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#show'
      get '/items/find', to: 'items/search#show'
      get '/merchants/find_all', to: 'merchants/search#index'
      get '/items/find_all', to: 'items/search#index'
      get '/merchants/:id/items', to: 'merchants/items#index'
      get '/items/:id/merchants', to: 'items/merchants#show'
      resources :merchants
      resources :items
    end
  end
end
