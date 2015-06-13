Rails.application.routes.draw do
  get 'votes/create'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  concern :has_votes do
  	resources :votes, only: :create
  end

  concern :has_questions do
    resources :questions, only: [:index, :new, :create]
  end

  post '/questions/:id/upvote/', to: 'votes#upvote', as: 'upvote_question'
  post '/questions/:id/downvote/', to: 'votes#downvote', as: 'downvote_question'

  resources :events, concerns: :has_questions
  get '/events/:id/close', to: 'events#close', as: 'close_event'
  get '/events/:id/open', to: 'events#open', as: 'open_event'


  root 'events#index'
end
