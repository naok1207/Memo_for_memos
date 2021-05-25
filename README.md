# メモのメモをするアプリケーション

Rails: 6.1.1
ruby: 3.0.0

エンドポイント
|済|内容|HTTP|エンドポイント|アクション|
|---|---|---|---|---|---|
||紹介ページ|GET|/home|home#home|
||||
||**カテゴリ**||
|A|初期ベージ(カテゴリ一覧)|GET|/|categories#index|
|A|カテゴリ詳細|GET|/categories/:name|categories#show|
|A|カテゴリ作成画面(ajax)|GET|/categories/new|categories#new|
|A|カテゴリ作成(ajax)|POST|/categories|categries#create|
|A|カテゴリ編集画面(ajax)|GET|/categories/:name/edit|categories#edit|
|A|カテゴリ更新|PATCH|/categories/:name|categories#update|
|A|カテゴリ削除|DELETE|/categories/:name|categories#destroy|
|A|メモ作成画面|GET|/categories/:cateogry_name/memos/new|memos#new|
|A|メモ作成|POST|/categories/:cateogry_name/memos/create|memos#create|
|A|メモ詳細|GET|/categories/:cateogry_name/memos/:id|memos#show|
|A|メモ編集画面|GET|/categories/:cateogry_name/memos/:id/edit|memos#edit|
|A|メモ更新|PATCH|/categories/:cateogry_name/memos/:id|memos#update|
|A|メモ削除|DELETE|/categories/:cateogry_name/memos/:id|memos#destroy|
||||
||**メモ**||
|A|メモ一覧|GET|/memos|memos#index|
||解決メモ一覧|GET|/memos/solved|memos/solve#solved|
||未解決メモ一覧|GET|/memos/unsolved|memos/solve#unsolved|
|A|メモ作成(api)|POST|/api/memos/create|api/memos#create|
||||
||**タグ**||
|A|タグ一覧|GET|/tags|tags#index|
|A|タグ詳細(タグに基づくメモ一覧)|GET|/tags/:name|tags#show|
|A|タグ作成画面(ajax)|GET|/tags/new|tags#new|
|A|タグ作成(ajax)|POST|/tags|tags#create|
||**ユーザ**||
|A|ユーザ詳細画面|GET|/:username|users#show|
|A|ユーザ編集画面|GET|/profile/edit|users#edit|
|A|ユーザ更新|PATCH|/:username|users#update|
|A|タグ一覧|GET|/:user_username/tags|users/tags#index|
|A|タグ詳細|GET|/:user_username/tags/:name|users/tags#show|
|A|カレンダー詳細|GET|/:user_username/calender/:year(/:month(/:day))|users/calenders#calender|
|A|カレンダー更新(ajax)|GET|/:user_username/calender/ajax/:change|users/calenders#ajax|
||プロフィール設定画面|GET|/mypage/edit|mypage/profile#edit|
||プロフィール更新|PATCH|/mypage/update|mypage/profile#update|
||||
||**認証**||
|A|ログイン画面|GET|/login|sessions#new|
|A|ログイン|POST|/login|sessions#create|
|A|ユーザ作成画面|GET|/signup|users#new|
|A|ユーザ作成|POST|/singup|users#create|
||||
||**その他**||
||管理者ページ|GET|/admin/bashboard|admin#dashboard|
||システム設定画面(ajax)|GET|/setting|setting#show|
状態レベル
[ ] 未制作
[A] 一時作成
[B] 修正必要
[C] 機能追加
[D] 最適化
