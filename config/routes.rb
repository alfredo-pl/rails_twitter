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
  get 'api/:date1/:date2', to: 'tweets#apibetween'
  post 'api/tweet', to: 'tweets#apiCreateTweet'
  root 'tweets#index'
 

end
