Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
   
    resources :likes
  end
  devise_for :users , controllers: {
    registrations: 'users/registrations'
  }
  get 'api/news' , to: 'tweets#apinews'
  root 'tweets#index'
 

end
