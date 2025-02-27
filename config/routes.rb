Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "login", to: "auth#login"
      post "signup", to: "auth#signup"

      # Routes for author profile management
      resource :authors, only: [ :show, :update ]
      resources :blogs do
        resources :comments, only: [ :index, :create ]
      end
      resources :comments, only: [ :show, :update, :destroy ]
    end
  end
end
