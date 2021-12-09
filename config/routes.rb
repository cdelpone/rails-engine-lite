Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items, except: :delete do
        resources :merchants, only: :index, controller: 'items_merchant'
        # get 'items/:id/merchant', to: 'items_merchant#show'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: :index, controller: 'merchants_items'
        # get 'merchants/:id/items', to: 'merchants_items#index'
      end
    end
  end
end
