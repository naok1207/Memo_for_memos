# メモのメモをするアプリケーション

Rails: 6.1.1
ruby: 2.6.4

エンドポイント
|内容|HTTP|エンドポイント|アクション|
|---|---|---|---|
|紹介ページ|GET|/home|home#home|
|初期ベージ(カテゴリ一覧)|GET|/|categories#index|
|カテゴリ詳細|GET|/categories/:name|categories#show|
|カテゴリ作成画面(ajax)|GET|/categories/new|categories#new|
|カテゴリ作成(ajax)|POST|/categories|categries#create|
|カテゴリ編集画面(ajax)|GET|/categories/:name/edit|categories#edit|
|カテゴリ更新(ajax)|PATCH|/categories/:name|categories#update|
|カテゴリ削除(ajax)|DELETE|/categories/:name|categories#destroy|
|メモ一覧|GET|/memos|memos#index|
|解決メモ一覧|GET|/memos/solved|memos/solve#solved|
|未解決メモ一覧|GET|/memos/unsolved|memos/solve#unsolved|
|メモ詳細|GET|/memos/:id|memos#show|
|メモ作成画面|GET|/memos/new|memos#new|
|メモ作成|POST|/memos/create|memos#create|
|メモ編集画面|GET|/memos/:id/edit|memos#edit|
|メモ更新|PATCH|/memos/:id|memos#update|
|メモ削除|DELETE|/memos/:id|memos#destroy|
|メモ作成(api)|POST|/api/memos/create|api/memos#create|
|タグ一覧|GET|/tags|tags#index|
|タグ詳細(タグに基づくメモ一覧)|GET|/tags/:name|tags#show|
|タグ作成画面(ajax)|GET|/tags/new|tags#new|
|タグ作成(ajax)|POST|/tags|tags#create|
|ユーザ詳細画面|GET|/:username|users#show|
|ユーザ編集画面|GET|/profile/edit|users#edit|
|ユーザ更新|PATCH|/:username|users#update|
|プロフィール設定画面|GET|/mypage/edit|mypage/profile#edit|
|プロフィール更新|PATCH|/mypage/update|mypage/profile#update|
|システム設定画面(ajax)|GET|/setting|setting#show|
|管理者ページ|GET|/admin/bashboard|admin#dashboard|
|ログイン画面|GET|/login|sessions#new|
|ログイン|POST|/login|sessions#create|
|ユーザ作成画面|GET|/signup|users#new|
|ユーザ作成|POST|/singup|users#create|
