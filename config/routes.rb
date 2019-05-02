Rails.application.routes.draw do
  resources :sentinels
  devise_for :users
  root to: "page#main"
  resources :weather_records
  resources :days
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
