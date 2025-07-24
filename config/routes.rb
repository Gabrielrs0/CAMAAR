Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Password definition
  get  "/definir-senha/:token", to: "senha_definicao#edit",   as: :definir_senha
  post "/definir-senha/:token", to: "senha_definicao#update"

  # Dashboard
  root "admin/dashboard#index"

  # Avaliações
  get "/avaliacoes", to: "avaliacoes#index", as: "avaliacoes"

  # Gerenciamento de etapas
  get  "/gerenciamento",        to: "gerenciamento#index"
  get  "/importar_dados",       to: "gerenciamento#importar_dados"
  get  "/editar_templates",     to: "gerenciamento#editar_templates"
  get  "/enviar_formularios",   to: "gerenciamento#enviar_formularios"
  get  "/resultados",           to: "gerenciamento#resultados"
  post "/enviar_formularios",   to: "gerenciamento#enviar_formularios"

  namespace :admin do
    # Importação SIGAA
    get  "import",      to: "imports#import_form",  as: :import_form
    post "import/sigaa", to: "imports#import_sigaa", as: :import_sigaa

    # Admin dashboard
    get "dashboard", to: "dashboard#index", as: :dashboard
  end
end
