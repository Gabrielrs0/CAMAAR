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

  # ===============================================================
  # ## Bloco de código para a rota de teste ##
  # Este bloco estava faltando. Ele cria a rota de login para testes.
  if Rails.env.test?
    namespace :test do
      get "login/:admin_id", to: "sessions#create", as: "test_login"
    end
  end
  # ===============================================================
end
