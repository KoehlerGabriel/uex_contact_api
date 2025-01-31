Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :contacts, only: [:index, :show, :create, :destroy, :update]
  resource :user, only: [:show, :update, :destroy]
  get 'addresses/search', to: 'addresses#search'
end
