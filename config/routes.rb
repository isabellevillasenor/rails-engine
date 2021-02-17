Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'search#index'
      end

      namespace :items do
        get 'find', to: 'search#show'
      end
    end
  end
end
