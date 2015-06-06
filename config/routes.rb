Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  concern :has_questions do
    resources :questions, only: [:index, :new, :create]
  end

  resources :events, concerns: :has_questions
  resources :questions

  root 'events#index'
end
