Rails.application.routes.draw do
  root "reading_logs#index"

  resources :reading_logs, only: [:show] do
    resources :books, only: [:show] do
      patch "toggle_chapter", to: "books#toggle_chapter"
    end

    member do
      get "settings"
    end
  end

  get "sign_in", to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  delete 'sign_out', to: "sessions#destroy"

  get "account", to: "users#account"
  patch "update_password", to: "users#update_password"

  get "admin", to: "base#admin"
  post "setup_user", to: "base#setup_user"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
