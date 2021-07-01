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

  resources :memos, only: %i[ index show ]

  resources :tags, param: :name, only: %i[ index show ]

  resource :bookmarks, only: %i[ show create destroy ]

  namespace :user_settings do
    resource :profile, only: %i[ show update ]
    resource :avatar, only: %i[ update destroy ] do
      post 'confirm', as: 'confirm'
    end
  end

  # 検索
  resource :searches, only: :show do
    # メモ、カテゴリの内容に関連する検索
    scope module: :searches do
      namespace :contents do
        resource :categories, only: :show
        resource :memos, only: :show
        resource :users, only: :show
      end
    end
  end

  resource :minds, only: :show

  namespace :api do
    resources :memos, only: %i[ create ]
  end


  # ユーザ関連
  resources :users, param: :username, path: '/', only: %i[ show create edit update destroy ] do
    resources :tags, param: :name, controller: 'users/tags', only: %i[ index show ]
    resource :profile, only: %i[ edit update ]
    # スコープでまとめるべき？
    get '/calender/:year(/:month(/:day))', to: 'users/calenders#calender', as: 'calender',
      constraints: lambda { |request|
        request.params[:year].to_s.match?(/\d{4}/) and
        (request.params[:month].nil? or request.params[:month].to_i.in?(1..12)) and
        (request.params[:day].nil? or request.params[:day].to_i.in?(1..31))
      }

    get 'calender/ajax/:change', to: 'users/calenders#ajax', as: 'calender_ajax'
  end

end
