Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  get "/tasks", to: "pages#tasks", as: "tasks"
  put "categories/:id/tasks/:id/async", to: "tasks#async_update", as: "async_update"
  resources :categories do
    resources :tasks
  end
end
