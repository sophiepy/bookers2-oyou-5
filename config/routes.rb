Rails.application.routes.draw do
  # get 'relationship/create'
  # get 'relationship/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  # 検索機能
  get "search/search" => "searches#search"
  # get "search/search" => "searches#search"
# フォロー機能追記do end 他OR users do からendend
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create,:destroy,:following, :followers]
    get "relationship/following" => "relationships#following"
    get "relationship/followed" => "relationships#followed"
  end
  # favoriteはresourseにSがつかない
  resources :books, only: [:new,:index,:show,:edit,:create,:destroy,:update]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end