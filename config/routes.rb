Rails.application.routes.draw do
  namespace :admin do
      resources :questions
      resources :users

      root to: "questions#index"
    end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
