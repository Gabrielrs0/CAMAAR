# API v1 – Controlador para CRUD de Templates via JSON
module Api
  module V1
    # Gerencia listagem, criação e consulta de Templates na versão 1 da API
    class TemplatesController < ApplicationController
      skip_before_action :verify_authenticity_token

      # GET /api/v1/templates
      # @return [JSON] Todos os templates
      def index
        render json: Template.all, status: :ok
      end

      # GET /api/v1/templates/:id
      # @return [JSON] Template encontrado ou mensagem de erro 404
      def show
        id       = params.fetch(:id)
        template = Template.find_by(id: id)

        if template
          render json: template, status: :ok
        else
          render json: { error: "Template com ID '#{id}' não encontrado" },
                 status: :not_found
        end
      end

      # POST /api/v1/templates
      # @param template_params [ActionController::Parameters] Apenas :title permitido
      # @return [JSON] Template criado ou lista de erros
      def create
        template = Template.new(template_params)

        if template.save
          render json: template, status: :created
        else
          render json: { errors: template.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private

      # Apenas :title é permitido
      def template_params
        params.require(:template).permit(:title)
      end
    end
  end
end
