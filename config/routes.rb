Rails.application.routes.draw do
  
  
  
  resources :posts, except: [:new]
  get "new-post", to: "posts#new", as: "new_post"
  
  get "dashboard", to:'dashboard#index'
  
  ################## USERS  ##########################
  devise_for :users
  devise_scope :user do
    get 'user-signin', to: 'devise/sessions#new'
    get 'user-signout', to: 'devise/sessions#destroy'
    get 'user-signup', to: 'devise/registrations#new'
    get 'user-edit', to: 'devise/registrations#edit'
  end
  resources :after_signupuser
  ################## ADMINS  ##########################
  devise_for :admins
  devise_scope :admin do
    get 'admin-signin', to: 'devise/sessions#new'
    get 'admin-signout', to: 'devise/sessions#destroy'
    get 'admin-signup', to: 'devise/registrations#new'
    get 'admin-edit', to: 'devise/registrations#edit'
  end
  resources :after_signupadmin
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
