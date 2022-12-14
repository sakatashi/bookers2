Rails.application.routes.draw do
root to: "homes#top"
get 'home/about' => "homes#about"
devise_for :users

resources :users,only:[:index,:update,:show,:edit]
resources :books,only:[:index,:show,:edit,:create,:destroy,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
resources :users do
  collection do
    get 'search'
  end
end
end
