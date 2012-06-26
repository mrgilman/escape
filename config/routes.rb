Escape::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  match '/auth/:provider/callback' => 'authentications#create'
  match '/' => 'home#index', :as => "root"
  resources :users
  resources :sessions
  resources :authentications
  resources :trips do
    resources :lodgings
  end
  resource :tripit, :controller => :tripit
  mount Resque::Server, :at => "/resque"
end
