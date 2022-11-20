Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :portfolios, only: [:index, :show, :edit, :update, :destroy] do
      resources :reviews, only: [:edit, :update, :destroy]
    end
    resources :categorys, only: [:index, :create, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: "homes#top"

    get 'my_page' => 'users#show'
    get 'information/edit' => 'users#edit'
    patch 'information' => 'users#update'
    delete 'information/destroy' => 'users#destroy'

    resources :portfolios, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :reviews, only: [:create, :edit, :update, :destroy]
    end

    get '/search', to: 'searches#word_search'
    get '/search', to: 'searches#tag_search'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
