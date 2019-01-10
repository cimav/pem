Rails.application.routes.draw do
  resources :pem_files
  root 'pem_files#index'

  #login
  get '/login' => 'login#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy'

end
