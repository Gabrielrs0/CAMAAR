Rails.application.routes.draw do
  # get "up" => "rails/health#show", as: :rails_health_check

  namespace "api" do
    namespace "v1" do
      scope "templates" do
        get "/", to: "templates#index"
        get "show/:id", to: "templates#show"
        post "create", to: "templates#create"
      end
    end
  end
end
