Rails.application.routes.draw do
  resources :subtopics_topics
  resources :topics_authors
  resources :disciplines_authors
  resources :topics_disciplines
  resources :resources
  resources :subtopics
  resources :authors
  resources :cards
  mount_devise_token_auth_for 'User', at: 'auth'

  get '/search/:queryType/page/:page',                                     to: 'search#index'
  
  get '/disciplines/page/:page',                                     to: 'disciplines#show'
  get '/topics/page/:page',                                     to: 'topics#show'
end
