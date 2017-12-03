# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :events
  resources :categories, only: %i[index destroy]
  get 'planning', to: 'events#planning'
  post 'combine', to: 'categories#combine'
  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
