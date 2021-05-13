Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "sessions#new"

  # 認証
  get     '/login',  to: "sessions#new"
  post    '/login',  to: "sessions#create"
  delete  '/logout',  to: "sessions#destroy"

  # ユーザ登録
  resources :users
end
