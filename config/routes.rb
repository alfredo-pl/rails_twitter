Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
   
    resources :likes
  end
  devise_for :users , controllers: {
    registrations: 'users/registrations'
  }
  
  root 'tweets#index'
 

end
