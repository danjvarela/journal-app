Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  get "/tasks", to: "pages#tasks", as: "tasks"
  resources :categories do
    resources :tasks
  end
end
