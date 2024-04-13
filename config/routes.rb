Rails.application.routes.draw do
  root 'base#index'
  get "admin", to: "base#admin"
  get "books", to: "base#books"
  resources :books, only: [] do
    patch "toggle_chapter", to: "books#toggle_chapter"
  end
  post "setup_user", to: "base#setup_user"
  get "sign_in", to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  delete 'log_out', to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
