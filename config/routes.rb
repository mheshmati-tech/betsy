Rails.application.routes.draw do

  # OAuth routes
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create", as: 'auth_callback'
  delete "/logout", to: "users#destroy", as: "logout"

  root to: 'users#index'

  resources :users, only: [:index, :show]

end
