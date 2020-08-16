Rails.application.routes.draw do
   namespace :api, defaults: { format: 'json' } do
    # get :v3, to: redirect('/swagger/index.html?uri=/swagger/v3/api.yml')
    namespace :v1 do
      namespace :github do
        resources :repositories, only: [:index]
      end
    end
  end
end