require 'sidekiq/web'

Rails.application.routes.draw do
  resources :websites do
    patch :update_status
  end
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  authenticated :user do
    root to: redirect("/websites"), as: :authenticated_root
  end
  # get 'pages/index'

  devise_scope :user do
    unauthenticated do
      root to: "users/sessions#new", as: :unauthenticated_root
    end
  end

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
