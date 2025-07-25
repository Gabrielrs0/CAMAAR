Rails.application.routes.draw do
  namespace :admin do
    resources :forms, only: [ :index, :show ] do
      member do
        get :report
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Root dentro do bloco:
  root "home#index"

<<<<<<< HEAD
  # ===============================================================
  # ## Bloco de código para a rota de teste ##
  # Este bloco estava faltando. Ele cria a rota de login para testes.
  if Rails.env.test?
    namespace :test do
      get "login/:admin_id", to: "sessions#create", as: "test_login"
    end
  end
  # ===============================================================
=======
  # Defines the root path route ("/")
  # root "posts#index"


  # Rotas de login e logout
  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  root to: "sessions#new" # VEFICAR SE ESTA ENCAMINHANDO PRO LUGAR CERTO


  # root 'pages#login'
>>>>>>> develop
end
