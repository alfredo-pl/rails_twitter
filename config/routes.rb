Rails.application.routes.draw do
  resources :tweets do
    member do
        post :retweet
    end
    resources :likes
  end
  devise_for :users , controllers: {
    registrations: 'users/registrations'
  }
  
  root 'tweets#index'
 

end
