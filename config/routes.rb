Rails.application.routes.draw do
  root 'blogs#index'
  resources :blogs do
    resources :favorites, only: [:create, :destroy]
  end
  devise_for :users
end

