Rails.application.routes.draw do
  root "reading_logs#index"

  resources :reading_logs, only: [:show] do
    resources :books, only: [:show] do
      member do
        patch "toggle_chapter", to: "books#toggle_chapter"
      end
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
  patch "update_time_zone", to: "users#update_time_zone"
  resource :password_reset

  get "admin", to: "base#admin"
  post "setup_user", to: "base#setup_user"

  get "up" => "rails/health#show", as: :rails_health_check
end
