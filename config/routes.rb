Rails.application.routes.draw do
  # Esta ruta debe ir de primero
  devise_for :users # Generada automáticamente por devise
  # Esta ruta contiene implicitamente las rutas
    # sign_in: 'login',
    # sign_out: 'logout',
    # password: 'secret',
    # confirmation: 'verification',
    # unlock: 'unblock',
    # registration: 'register',
    # sign_up: 'signup'
  
  root to: 'home#index'

  get 'welcome', to: 'home#index'

  # Article
  resources :articles # Esta sola línea genera todas las rutas del crud, siguiendo las convenciones de ruby
  # get 'articles', to: 'articles#index'

  # get 'articles/new', to: 'articles#new', as: :new_articles
  # post 'articles', to: 'articles#create'

  # get 'articles/:id', to: 'articles#show'

  # get 'articles/:id/edit', to: 'articles#edit'
  # patch 'articles/:id', to: 'articles#update', as: :article # de esta forma definimos un nombre de ruta, con `as`

  # delete 'articles/:id', to: 'articles#destroy' 

  # Article <-> User
  get 'articles/user/:id', to: 'articles#by_user' 

  # Category
  resources :categories
  
end
