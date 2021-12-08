Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/:id/items', to: 'merchants_items#index'
      # get 'items/:id/merchant', to: 'items_merchant#show'
      resources :items, except: :delete
      resources :merchants, only: [:index, :show]
      # resources :merchants, only: [:index, :show] do
      #   resources :items, only: :index
      # end
      # resources :items, only: [:index, :show] do
      #   resources :merchants, only: :index
      # end
    end
  end
end
