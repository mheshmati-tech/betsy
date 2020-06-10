Rails.application.routes.draw do

  # OAuth routes
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create"
  delete "/logout", to: "users#destroy", as: "logout"

  resources :users, only: [:index, :show]

end
