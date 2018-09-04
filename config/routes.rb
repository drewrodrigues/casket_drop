Rails.application.routes.draw do
  resources :users, except: %i[new create]
  get "get-started" => "users#new"
  post "get-started" => "users#create"

  root "pages#landing"
  get "dashboard" => "pages#dashboard"
  get "admin" => "pages#admin"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  get "subscribe" => "subscriptions#new"
end
