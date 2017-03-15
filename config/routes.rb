require_or_load 'instagram'

Rails.application.routes.draw do
  get 'instagram/login'
  get 'instagram/callback'

  devise_for :users
  resources :places
  get '/instagram' => "static_pages#instagram"
  get '/result' => "static_pages#result"
  get "/details" => "static_pages#details"
  root "static_pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
