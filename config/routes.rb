Escape::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  match '/auth/:provider/callback' => 'authentications#create'
  resources :users
  resources :sessions
  resources :authentications
  resources :trips
  resource :tripit, :controller => :tripit
  mount Resque::Server, :at => "/resque"
end
