Rails.application.routes.draw do
  resources :comments
  resources :users
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#	get 'pages/home', to: 'pages#home'
#	get 'pages/about', to: 'pages#about' 

  #next we will update routes for app example we want http://localhost:3000/ for home and
  #http://localhost:3000/about for about and then run rake routes to check the prefix for path.
	root 'pages#home'
	get 'about', to: 'pages#about'





end
