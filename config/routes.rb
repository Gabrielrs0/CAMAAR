Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get  '/definir-senha/:token', to: 'senha_definicao#edit',   as: :definir_senha
  post '/definir-senha/:token', to: 'senha_definicao#update'
  root "admin/dashboard#index"


  get "/gerenciamento", to: "gerenciamento#index"
  get "/importar_dados", to: "gerenciamento#importar_dados"
  get "/editar_templates", to: "gerenciamento#editar_templates"
  get "/enviar_formularios", to: "gerenciamento#enviar_formularios"
  get "/resultados", to: "gerenciamento#resultados"
  get 'gerenciamento/importar_dados', to: 'gerenciamento#importar_dados'
  post "/enviar_formularios", to: "gerenciamento#enviar_formularios"
  get "/resetar_etapas", to: "gerenciamento#resetar_etapas"



  namespace :admin do
    post 'import/sigaa', to: 'imports#import_sigaa'
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'
    get 'import', to: 'imports#import_form'

  end
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
