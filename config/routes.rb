Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show, :create, :update]
      
      namespace :merchants do
        get '/find_all', to: 'search#index'
      end
      
      resources :items, only: [:index, :show, :create]
      
      namespace :items do
        get 'find', to: 'search#show'
      end
    end
  end
end
