Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :skip => [:registrations, :passwords]

  concern :has_votes do
  	resources :votes, only: :create
  end

  concern :has_questions do
    resources :questions, only: [:new, :create]
  end

  get '/questions/:id/responses/new', to: 'responses#new', as: 'new_question_response'
  get '/questions/:id/responses', to: 'responses#index', as: 'question_responses'
  post '/questions/:id/responses', to: 'responses#create'
  resources :responses, only: [:destroy, :edit, :update]

  resources :questions, only: [:destroy, :edit, :update]
  post '/questions/:id/upvote/', to: 'votes#upvote', as: 'upvote_question'
  post '/questions/:id/downvote/', to: 'votes#downvote', as: 'downvote_question'

  resources :events, concerns: :has_questions
  get '/events/:id/close', to: 'events#close', as: 'close_event'
  get '/events/:id/open', to: 'events#open', as: 'open_event'

  get '/users', to: 'users#index', as: 'users'
  post '/users/:id', to: 'users#update', as: 'user'
  get '/users/:id/questions', to: 'users#show_questions', as: 'user_questions'
  get '/users/:id/votes', to: 'users#show_votes', as: 'user_votes'

  root 'events#index'
end
