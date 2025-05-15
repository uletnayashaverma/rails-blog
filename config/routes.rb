Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    # Важно , подметь это ...
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
    end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
    # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

    # Defines the root path route ("/")
    root "posts#index"
    resources :posts, only: [:show, :index]
    resources :tags, only: [:show]
    resources :categories, only: [:show]

    namespace :admin do
      resources :posts, except: [:show, :index]
      resources :categories, except: [:show]
    end
  end
end
