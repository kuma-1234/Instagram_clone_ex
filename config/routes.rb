Rails.application.routes.draw do
  resources :sessions, only:[ :new, :create, :destroy ]
  resources :users
  resources :blogs do
    collection do
      post :collection
    end
  end
end
