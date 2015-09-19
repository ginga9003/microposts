Rails.application.routes.draw do
  get 'sessions/new'

  # root
  root to: 'static_pages#home'
  
  # モデルを持たないが、任意のURLで処理を行いたい場合の
  # ルーティングを定義
  get    'signup', to: 'users#new'
  #get    'users/:id/followings', to: 'users#followings', :as :followings
  #get    'followers/:id', to: 'users#followers'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  # 以下は１行で一通りのルーティングを作成する
  # index, show, new, edit, create, update, destroy
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
