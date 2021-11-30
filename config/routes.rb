Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :api do
    namespace :v1 do
      root 'books#index'
      resources :books, only: %i[index show create update destroy]
      resources :authors, only: %i[index show create update destroy]
    end
  end
end
