class Api::V1::TemplatesController < ApplicationController
  # O before_action não precisa de alteração
  before_action :set_template, only: %i[show]
  skip_before_action :verify_authenticity_token

  def index
    templates = Template.all
    render json: templates, status: :ok
  end

  # O rescue foi removido daqui, pois era inalcançável
  def show
    render json: @template, status: :ok
  end

  def create
    @template = Template.new(template_params)

    if @template.save
      render json: @template, status: :created
    else
      render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Correção: O tratamento da exceção é feito aqui
  def set_template
    @template = Template.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Template com ID '#{params[:id]}' não encontrado" }, status: :not_found
  end

  def template_params
    params.require(:template).permit(:title)
  end
end









  

  

#   def create
#     template = Template.new(template_params)
#     template.save!
#     render json: template, status: :created
#   rescue ActiveRecord::RecordInvalid => e
#     render json: { error: e.message }, status: :unprocessable_entity
#   end

#   private

#   def template_params
#     params.expect(template: %i[title])
#   end
# end






# # frozen_string_literal: true

# # Adicione um comentário de documentação para a classe TemplatesController.
# class TemplatesController < ApplicationController
#   before_action :set_template, only: %i[show edit update destroy]

#   # GET /templates or /templates.json
#   def index
#     @templates = Template.all
#   end

#   # GET /templates/1 or /templates/1.json
#   def show; end

#   # GET /templates/new
#   def new
#     @template = Template.new
#   end

#   # GET /templates/1/edit
#   def edit; end

#   # POST /templates or /templates.json
#   def create
#     @template = Template.new(template_params)

#     respond_to do |format|
#       if @template.save
#         format.html { redirect_to @template, notice: 'Template was successfully created.' }
#         format.json { render :show, status: :created, location: @template }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @template.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /templates/1 or /templates/1.json
#   def update
#     respond_to do |format|
#       if @template.update(template_params)
#         format.html { redirect_to @template, notice: 'Template was successfully updated.' }
#         format.json { render :show, status: :ok, location: @template }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @template.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /templates/1 or /templates/1.json
#   def destroy
#     @template.destroy!

#     respond_to do |format|
#       format.html { redirect_to templates_path, status: :see_other, notice: 'Template was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end

#   private

#   # Use callbacks to share common setup or constraints between actions.
#   def set_template
#     @template = Template.find(params.expect(:id))
#   end

#   # Only allow a list of trusted parameters through.
#   def template_params
#     params.expect(template: %i[titulo publico_alvo criado_por_id])
#   end
# end