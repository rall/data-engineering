Vagrant::Application.routes.draw do
  resources :purchases, only: :index
  resources :batch_purchases, only: [:create, :new, :show]
end
