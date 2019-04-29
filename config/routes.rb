Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :groups do
  	member do
  		get :join_group
  	end
  	resources :notices
  end

  resources :home do
  	collection do
  		get :notices
  	end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
