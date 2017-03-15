Rails.application.routes.draw do
  devise_for :users
  resources :places
  get 'static_pages/home'
  get 'static_pages/result'
  get "static_pages/details" => "static_pages#details"
  root "static_pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
