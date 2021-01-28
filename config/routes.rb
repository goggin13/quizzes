Rails.application.routes.draw do
  resources :exams do
    resources :questions, only: [:index, :new, :create]
  end

  resources :questions, only: [:show, :edit, :update, :destroy] do
    resources :answers, only: [:index, :new, :create]
  end
  resources :answers, only: [:show, :edit, :update, :destroy]
end
