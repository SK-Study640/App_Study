# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  root 'home#index'

  get 'typing/home'
  get 'typing/start', to: 'typing#start', as: 'typing_start'
  get 'typing/reset', to: 'typing#reset', as: 'typing_reset'
  post 'typing/check_answer/:game_id', to: 'typing#check_answer', as: 'typing_check_answer'
  get 'typing/result/:game_id', to: 'typing#result', as: 'typing_result'
  get 'typing/play/:game_id', to: 'typing#play', as: 'typing_play'

  namespace :admin do
    resources :users, only: %i[index edit update]
  end
end
