Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  resources :posts
  devise_for :user, :controllers => { registrations: 'registration' }
  resources :places
  resources :users do
    member do
      get :following, :followers
    end
  end
  root "static_pages#home"
  get "/search" => "static_pages#search"
  get 'users/:id' => 'users#show'
  get '/unfollow/:id' => 'users#unfollow_user'
  get '/follow/:id' => 'users#follow_user'
  get '/ban/:id' => 'users#ban_user'
  get '/ban' => "static_pages#ban"
  get '/profile' => "static_pages#profile"
  get '/result' => "static_pages#result"
  get "/googledetails" => "static_pages#googledetails"
  get "/yelpdetails" => "static_pages#yelpdetails"
  get "/foursquaredetails" => "static_pages#foursquaredetails"
  get '404', :to => 'application#page_not_found'
  get  '/:anything', :to => "application#page_not_found"
  #get "*all" =>  "application#path_error"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
