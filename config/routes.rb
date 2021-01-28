Rails.application.routes.draw do
  resources :answers
  resources :exams do
    resources :questions, only: [:index, :new, :create]
  end
  resources :questions, only: [:show, :edit, :update, :destroy]
end
