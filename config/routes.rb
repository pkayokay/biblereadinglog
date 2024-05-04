Rails.application.routes.draw do
  root "reading_logs#index"

  resources :reading_logs, except: :edit do
    resources :books, only: [:show] do
      member do
        patch "toggle_chapter", to: "books#toggle_chapter"
        patch "pin_book", to: "books#pin_book"
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
  patch "update_color_theme", to: "users#update_color_theme"
  patch "update_name", to: "users#update_name"
  get "email_confirmation", to: "users#email_confirmation"
  resource :password_reset

  get "admin", to: "base#admin"
  post "setup_user", to: "base#setup_user"

  get "up" => "rails/health#show", as: :rails_health_check
end
