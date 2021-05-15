Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "sessions#new"

  # 認証
  get     '/login',  to: "sessions#new"
  post    '/login',  to: "sessions#create"
  delete  '/logout', to: "sessions#destroy"
  get     '/signup', to: "users#new"

  # カテゴリ & メモ
  resources :categories, param: :name do
    resources :memos, controller: 'categories/memos', only: %i[ show new create edit update destroy]
  end
  resources :memos, only: %i[ index ]

  # ユーザ関連
  resources :users, param: :username, path: '/', only: %i[ show create update destroy ]
  scope :profile do
    get 'edit', to: "users#edit", as: 'edit_user'
  end
end
