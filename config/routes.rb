Rails.application.routes.draw do
  root 'dashboard#index'

  resources :boards do
    resources :tasks do 
      member do
        put :complete
      end
    end
  end
end
