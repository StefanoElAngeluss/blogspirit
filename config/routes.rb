# frozen_string_literal: true

Rails.application.routes.draw do
  root 'accueil#index'
  get 'profil', to: 'users#index', as: 'profil'
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  resources :users do
    member do
      patch :ban
      patch :resend_invitation
    end
  end
  
  resources :posts do
    member do
      delete :purge_image
      patch 'upvote', to: 'posts#upvote'
      patch 'downvote', to: 'posts#downvote'
      
      patch :update_status
    end
  end

  resources :products
  resources :checkout, only: %i[create]
  post "checkout/create", to: "checkout#create", as: 'checkout_create'
  
  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_fichiers'
  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_avatar'
end
