Rails.application.routes.draw do
  resources :users

  get "dashboard" => "pages#dashboard"
  get "admin" => "pages#admin"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  get "subscribe" => "subscriptions#new"
end
