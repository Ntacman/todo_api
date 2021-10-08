Rails.application.routes.draw do
  resources :users
  resources :tasks
  get '/login' => 'users#login'
  get '/completed_tasks' => 'tasks#completed_tasks'
  get '/uncompleted_tasks' => 'tasks#uncompleted_tasks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
