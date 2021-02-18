Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: [:new, :edit]
      
      namespace :merchants do
        get '/find_all', to: 'search#index'
      end
      
      resources :items, except: [:new, :edit]
      
      namespace :items do
        get 'find', to: 'search#show'
      end
    end
  end
end
