Rails.application.routes.draw do

  root 'accueil#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations" }


  resources :posts do
    member do
      patch "upvote", to: "posts#upvote"
      patch "downvote", to: "posts#downvote"
    end
  end

end
