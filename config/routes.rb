Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  namespace :typing do
    get "typing/home", to: "typing#home"
    get "game/play", to: "home#play", as: :game_play
    get "game/submit_answer", to: "home#submit_answer", as: :game_submit_answer
    get "game/finished", to: "home#finished", as: :game_finished
  end
end
