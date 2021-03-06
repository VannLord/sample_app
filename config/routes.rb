 Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    get :help, to: "static_pages#help"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
    delete "/logout", to: "sessions#destroy"
    resources :account_activations, only: :edit
    resources :users
    resources :password_resets, except: [:index, :show, :destroy]
  end
end
