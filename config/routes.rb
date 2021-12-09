Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/:id/items', to: 'merchants_items#index'
      resources :items, except: :delete
      resources :merchants, only: [:index, :show]
      get 'items/:id/merchant', to: 'items_merchant#show'
    end
  end
end
