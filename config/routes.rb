Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'find#show'
      end
      namespace :items do
        get 'find_all', to: 'find_all#index'
      end
      resources :items, except: :delete
      get 'items/:id/merchant', to: 'items_merchant#show'
      resources :merchants, only: [:index, :show]
      get 'merchants/:id/items', to: 'merchants_items#index'
    end
  end
end

# won't work with show or index
# resources :items, except: :delete do
#   resources :merchant, only: :show, controller: 'items_merchant'
# end
# resources :merchants, only: [:index, :show] do
#   resources :items, only: :index, controller: 'merchants_items'
# end
