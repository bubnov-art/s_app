Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  namespace :users do
    get 'omniauth_callbacks/vkontakte'
  end

	get 'pages/feedback'
	get 'pages/about'
	devise_for :users, controllers:{
	  registrations: 'users/registrations', except: [:edit],
	  omniauth_callbacks: "users/omniauth_callbacks"
	}, skip: [:edit]
	get '/account' => 'users#show', as: :account
	root 'pages#home'
	
	namespace :admin do
		root 'users#index'
		resources :users
		post 'users/change-state' => 'users#change_user_state'
	end
end
