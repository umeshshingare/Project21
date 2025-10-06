Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      # Authentication routes
      post 'auth/register', to: 'authentication#register'
      post 'auth/login', to: 'authentication#login'
      post 'auth/logout', to: 'authentication#logout'
      get 'auth/me', to: 'authentication#me'
      post 'auth/forgot_password', to: 'authentication#forgot_password'
      post 'auth/reset_password', to: 'authentication#reset_password'

      # Resource routes
      resources :users, only: [:index, :show, :update, :destroy]
      resources :projects do
        resources :tasks, only: [:index, :create]
      end
      resources :tasks, only: [:index, :show, :create, :update, :destroy] do
        patch :status, on: :member
      end
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
