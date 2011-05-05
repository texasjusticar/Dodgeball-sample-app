Dodgeball::Application.routes.draw do
  resources :games

  resources :teams do
    member do
      post 'add_player'
      get 'remove_player'
    end
  end

  resources :players
  
  root :to => "main#index"
end
