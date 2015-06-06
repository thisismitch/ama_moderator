Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

   # get '/events/:event_id/questions/new', to: 'questions#new', as: 'new_event_question'
   # post '/events/:event_id/questions', to: 'questions#create'
  concern :has_questions do
    resources :questions, only: [:index, :new, :create]
  end

  resources :events, concerns: :has_questions
  resources :questions

  root 'events#index'
end
