Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
	scope "(:locale)", locale: /en|vi/ do
		root to: "static_pages#home"
		get "static_pages/help"
		get "/signup", to: "users#new"
		post "/signup", to: "users#create"
		get "login", to: "sessions#new"
		post "login", to: "sessions#create"
		delete  "logout" , to: "sessions#destroy"

		resources :users do
			member do
				get :following, :followers
			end
		end
		resources :account_activations, only: :edit
		resources :password_resets, only: [:new, :create, :edit, :update]
		resources :microposts, only: [:create, :destroy]
		resources :relationships, only: [:create, :destroy]


	end

end
