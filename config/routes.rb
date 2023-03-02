Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
      resources :questions
      resources :users
      root to: "questions#index"
    end

end
