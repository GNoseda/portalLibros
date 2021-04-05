Rails.application.routes.draw do
  devise_for :users
  resources :books
  post 'books/:id', to: "books#status", as: "status"
  post 'books/:id/drop', to: "books#drop", as: "drop"

  put 'users/:id', to: "users#status0", as: "status0"
  post 'users/:id', to: "users#user_status", as: "user_status"
  post 'users/:id/buy', to: "users#buy", as: "buy"
  post 'users/:id/loose', to: "users#loose", as: "loose"
  get 'users/:id', to: "users#profile", as: "user_reservations"
  
  root 'books#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
