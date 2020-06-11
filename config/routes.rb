Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

  # OAuth routes
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create", as: 'auth_callback'
  delete "/logout", to: "users#destroy", as: "logout"

  root to: "homepages#index"

  resources :users, only: [:index, :show]
  resources :products do
    resources :order_items, only: [:create]
  end



end
