Rails.application.routes.draw do
  root "reading_logs#index"

  resources :reading_logs, except: [:index, :edit] do
    member do
      get "show_stats"
    end
    resources :books, only: [:show] do
      member do
        post "toggle_chapter", to: "books#toggle_chapter"
        patch "pin_book", to: "books#pin_book"
      end
    end

    member do
      get "settings"
    end
  end

  get "/r/:slug", to: "reading_logs#invite", as: :reading_log_invite
  get "/r/:slug/join", to: "reading_logs#join_invite", as: :join_reading_log_invite
  get "sign_in", to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  delete 'sign_out', to: "sessions#destroy"

  post "flash_message", to: "base#flash_message"
  get "account", to: "users#account"
  patch "update_password", to: "users#update_password"
  patch "update_time_zone", to: "users#update_time_zone"
  patch "update_color_theme", to: "users#update_color_theme"
  patch "update_name", to: "users#update_name"
  get "email_confirmation", to: "users#email_confirmation"
  get "verify_email_confirmation_token", to: "users#verify_email_confirmation_token", as: :verify_email_confirmation_token
  post "resend_email_confirmation", to: "users#resend_email_confirmation"
  resource :password_reset

  get "admin", to: "base#admin"
  get "feedback", to: "base#feedback"
  post "setup_user", to: "base#setup_user"

  get "up" => "rails/health#show", as: :rails_health_check
end
