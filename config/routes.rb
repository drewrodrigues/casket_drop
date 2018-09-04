Rails.application.routes.draw do
  resources :users, except: %i[new create]
  get "get-started(/:email)" => "users#new", as: "get_started"
  post "get-started" => "users#create"

  root "pages#landing"
  get "dashboard" => "pages#dashboard"
  get "admin" => "pages#admin"

  get "login(/:email)" => "sessions#new", as: "login"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  get "subscribe" => "subscriptions#new"
end
