Rails.application.routes.draw do
  resources :subtopics_topics
  resources :topics_authors
  resources :disciplines_authors
  resources :topics_disciplines
  resources :resources
  resources :subtopics
  resources :topics
  resources :authors
  resources :disciplines
  resources :cards
  mount_devise_token_auth_for 'User', at: 'auth'

  get '/search/:queryType/page/:page',                                     to: 'search#index'
end
