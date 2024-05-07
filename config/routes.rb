Rails.application.routes.draw do

  # Kullanıcı kaydı ve girişi için özel rotalar
  resources :sessions, only: [:create, :destroy]
  resources :users, only: [:new, :create]
  post '/register', to: 'users#create', as: :register
  post '/login', to: 'sessions#create', as: :login
  post '/logout', to: 'sessions#destroy', as: :logout

  resources :books, only: [:index, :show, :create, :update, :destroy]

  resource :cart, only: [:show] do
    post 'checkout', on: :member
    post 'clear', on: :member
    resources :cart_items, only: [:create, :update, :destroy]
  end

  # Sağlık durumu kontrolü için rota
  get '/up', to: 'rails/health#show', as: :rails_health_check

  # Ödeme için rotalar
  post '/payments/process_payment', to: 'payments#process_payment'
end
