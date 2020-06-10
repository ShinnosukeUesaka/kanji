Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'usertop#main'
  
  get 'top/index'
  
  get 'top', to: 'usertop#main'
  get  'setting', to: 'usertop#setting'
  
 
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  
  
  get 'plan', to: 'planpages#firstpage'
  get 'plan/select', to: 'planpages#select'
  get 'plan/kanken', to: 'planpages#kanken'
  get 'plan/levels', to: 'planpages#nonkanken'
  post 'plan/explanation', to: 'planpages#explanation'
  
  get 'quiz/question'
  get 'quiz/answer'
  post 'quiz/post_answer'
  get 'quiz/finished'
  
  
  
  post 'datedev', to: 'datedev#progress_oneday'
  
  
  #scope :admin/ 
  resources :questions
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :show, :create, :destroy]
  
end
