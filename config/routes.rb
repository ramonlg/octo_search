Rails.application.routes.draw do
   namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :session, only: [:create]

      namespace :github do
        resources :repositories, only: [:index]
      end
    end
  end
end