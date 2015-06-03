Rails.application.routes.draw do

  get 'welcome/about', as: "about"
  get 'welcome/contact', as: "contact"

  devise_for :users, path: "/", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }, controllers: { registrations: "registrations"}

  resources :maps

  resources :users, only: :show do
    resources :maps, only: :index
  end
  resources :contact_messages, only: :create
  authenticated do
    root 'welcome#index'
  end

  root 'welcome#index', as: "guest_root"
end
