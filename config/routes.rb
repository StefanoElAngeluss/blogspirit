Rails.application.routes.draw do

  root 'accueil#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations" }


  resources :posts do
    member do
      delete :purge_image
      patch "upvote", to: "posts#upvote"
      patch "downvote", to: "posts#downvote"
    end
  end

  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_fichiers"

end
