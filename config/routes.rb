Rails.application.routes.draw do

  root 'accueil#index'
  get "profil", to: "users#profil", as: "profil"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
    confirmations: "users/confirmations" }
  resources :users, only: [:profil] do
    member do
      patch :ban
      patch :resend_invitation
    end
  end

  resources :posts do
    member do
      delete :purge_image
      patch "upvote", to: "posts#upvote"
      patch "downvote", to: "posts#downvote"
    end
  end

  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_fichiers"
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_avatar" 

end
