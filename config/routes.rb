Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :portfolios, only: [:index, :show, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: "homes#top"

    get 'my_page' => 'users#show'
    get 'information/edit' => 'users#edit'
    patch 'information' => 'users#update'
    delete 'information/destroy' => 'users#destroy'

    resources :portfolios, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
