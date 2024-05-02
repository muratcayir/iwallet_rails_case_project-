Rails.application.routes.draw do
  root 'users#new'
  post '/process_payment', to: 'payments#process_payment'
  # Kullanıcı kaydı ve girişi için özel rotalar
  resources :sessions, only: [:create, :destroy]
  post '/register', to: 'users#create', as: :register
  post '/login', to: 'sessions#create', as: :login
  post '/logout', to: 'sessions#destroy', as: :logout

  # Kitaplarla ilgili rotalar
  resources :books, only: [:index, :show, :create, :update, :destroy]

  # Sepet öğeleriyle ilgili rotalar
  resources :cart_items, only: [:index, :show, :create, :update, :destroy]

  # Sepet ile ilgili rotalar
  resources :carts, only: [:index, :show, :create, :update, :destroy]

  # Sağlık durumu kontrolü için rota
  get '/up', to: 'rails/health#show', as: :rails_health_check

  # Kullanıcı kaydı ve girişi için yeni sayfalar için rotalar

end
