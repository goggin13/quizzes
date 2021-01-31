Rails.application.routes.draw do
  devise_for :users
  resources :exams do
    resources :questions, only: [:index, :new, :create]
  end

  resources :questions, only: [:show, :edit, :update, :destroy] do
    resources :answers, only: [:index, :new, :create]
  end
  resources :answers, only: [:show, :edit, :update, :destroy]

  get 'public/index'
  root to: "public#index"
  get 'public/practice/:question_id', to: 'public#practice', as: :public_practice
end
