Rails.application.routes.draw do
  root 'sessions#new'
  get '/sessions/new'
  get '/events' => 'events#index'
  get '/users/:id' => 'users#edit'

  post '/users' => 'users#create'
  patch '/users/:id' => 'users#update'
  post '/sessions' => 'sessions#create'
  delete '/sessions/:id' => 'sessions#destroy'
  post '/events' => 'events#create'
  get '/events/:id' => 'events#show'
  get '/events/:id/edit' => 'events#edit'
  patch '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#delete'
  post '/events/:id/join' => 'events#join'
  delete '/events/:id/join' => 'events#cancel'
  post '/comments/:id' => 'comments#create'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
