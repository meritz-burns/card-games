Rails.application.routes.draw do
  root to: 'games#index'

  resources :joins, only: [:new, :create]

  resources :games, only: [:new, :create, :index] do
    resource :join, only: [:update]
  end

  resources :players, only: [] do
    resource :game, only: [:show]
    resource :card_movement, only: [:create]
    resource :discard, only: [:show]
    resource :win, only: [:create]
    resource :lose, only: [:create]
  end
end
