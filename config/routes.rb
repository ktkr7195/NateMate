Rails.application.routes.draw do
  get 'users/show'
  devise_for :users,:controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts,          only: [:new,:create, :destroy]
  get'/microposts'=>'microposts#index'
  resources :relationships,       only: [:create, :destroy]

  root 'static_pages#home'

  get  '/contact' => 'static_pages#contact'
end
