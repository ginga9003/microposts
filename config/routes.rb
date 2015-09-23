Rails.application.routes.draw do
  get 'sessions/new'

  # root
  root to: 'static_pages#home'
  
  # モデルを持たないが、任意のURLで処理を行いたい場合の
  # ルーティングを定義
  get    'signup', to: 'users#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  # 以下は１行で一通りのルーティングを作成する
  # index, show, new, edit, create, update, destroy
  resources :users do
    member do
      get :followings
      get :followers
      get :favorites
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :retweets, only: [:create, :destroy]
end
