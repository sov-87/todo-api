Rails.application.routes.draw do
  root 'dashboard#index'

  # более удобным было бы REST API, без использования вложенных ресурсов
  resources :boards do
    resources :tasks do
      member do
        put :complete
      end
    end
  end
end
