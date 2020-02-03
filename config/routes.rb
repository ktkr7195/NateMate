Rails.application.routes.draw do
  root 'static_pages#home'
  get 'likes/create'
  get 'likes/destroy'
  get 'users/show'
  get  '/contact' => 'static_pages#contact'
  devise_for :users,:controllers => {
                    :registrations => 'users/registrations',
                    :sessions => 'users/sessions'
  }
  devise_scope :user do
    get "sign_in", :to => 'users/sessions#new'
    get "sign_out",:to => 'users/sessions#destroy'
  end
  resources :users
  resources :microposts,          only: [:new, :create, :destroy, :show, :index]
  resources :relationships,       only: [:create, :destroy]
  resources :likes,               only: [:create, :destroy]
end
