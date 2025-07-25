class Admin::FormsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_form, only: [ :show, :report ]

  # GET /admin/forms
  def index
    @forms = Form.includes(:subject, :template).order(created_at: :desc)
  end

  # GET /admin/forms/:id
  def show
    @answers = @form.answers.includes(:user, :question)
  end

  # GET /admin/forms/:id/report
  def report
    @answers = @form.answers.includes(:user, :question)

    respond_to do |format|
      format.html

      format.csv do
        if @answers.empty?
          redirect_to admin_form_path(@form), alert: "Não há respostas disponíveis para exportar"        else
          send_data generate_csv(@answers), filename: "relatorio-formulario-#{@form.id}.csv"
        end
      end
    end
  end

  private

  def set_form
    @form = Form.find(params[:id])
  end

  def generate_csv(answers)
    CSV.generate(headers: true) do |csv|
      csv << [ "Usuário", "Email", "Pergunta", "Resposta", "Data" ]

      answers.each do |answer|
        csv << [
          answer.user.name,
          answer.user.email,
          answer.question.title,
          answer.answer_text || answer.answer_alternative,
          answer.created_at.strftime("%d/%m/%Y %H:%M")
        ]
      end
    end
  end

  def authenticate_admin!
    unless current_admin
      redirect_to root_path, alert: "Você precisa estar logado como administrador."
    end
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end
end
