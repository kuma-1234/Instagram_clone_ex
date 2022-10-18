Rails.application.routes.draw do
  root 'users#new'
  resources :sessions, only:[ :new, :create, :destroy ]
  resources :users
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :favorites, only:[ :create, :destroy, :show ]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
