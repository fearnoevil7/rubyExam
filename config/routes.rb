Rails.application.routes.draw do
  
  get '/groups' => "groups#index"
  
  get '/' => "users#index"
  
  post '/users' => "users#create"
  post '/groups' => "groups#create"
  delete "/sessions" => "sessions#destroy"
  delete '/groups/:groupid' => "groups#destroy"
  get '/groups/:groupid' => "groups#show"
  post '/joins/:groupid' => "joins#create"
  delete '/joins/:groupid' => "joins#destroy"
  get '*path' => 'users#index'#,constraints: lambda { |request| request.path =~ /.+\.users/ }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, :groups, :sessions, :joins
end
