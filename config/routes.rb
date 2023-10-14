Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :new] do
    resources :likes, only: [:create]
    resources :comments, only: [:create, :new]
  end
end
root 'users#index'
end
