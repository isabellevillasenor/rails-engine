Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find_all', to: 'search#index'
        get '/find_one', to: 'search#show'
        get '/most_revenue', to: 'logic#most_revenue'
        get '/most_items', to: 'logic#most_items'
      end
      
      resources :merchants, except: [:new, :edit]
      
      namespace :items do
        get '/:id/merchant', to: 'merchants#index'
        get '/find_all', to: 'search#index'
        get '/find_one', to: 'search#show'
      end
      
      resources :items, except: [:new, :edit]
    end
  end
end
