Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'top/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#index'
  
  #scope :admin/ 
  resources :questions
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  
  
  get 'plan', to: 'planpages#firstpage'
  get 'plan/select', to: 'planpages#select'
  get 'plan/kanken', to: 'planpages#kanken'
  get 'plan/levels', to: 'planpages#nonkanken'
  post 'plan/explanation', to: 'planpages#explanation'
  
  
  
  
  resources :users, only: [:index, :show, :new, :create, :destroy]
  
end
