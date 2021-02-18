Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      
      namespace :merchants do
        get '/find_all', to: 'search#index'
      end
      
      resources :items, only: [:index, :show]
      
      namespace :items do
        get 'find', to: 'search#show'
      end
    end
  end
end
