# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :questions, only: %i[index edit update show create new]
    resources :users, only: %i[index show]
    root to: 'questions#index'
  end
  # get 'user/api/v1/user'
  namespace :api do
    namespace :v1 do
      post :auth, to: 'authentication#create'
      delete :auth, to: 'authentication#destroy'
      resources :users, only: %i[create show destroy update index get_top_users] do
        collection do
          get '/topusers', to: 'users#get_top_users'
        end
      end
      resources :questions
    end
  end
end
