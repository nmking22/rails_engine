Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # items
  namespace :api do
    namespace :v1 do
      resources :items
      resources :merchants
    end
  end
end
