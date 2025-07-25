# app/controllers/test/sessions_controller.rb

# Este controller só é usado pela nossa rota de teste.
class Test::SessionsController < ApplicationController
  # Esta action cria a sessão e redireciona.
  def create
    session[:admin_id] = params[:admin_id]
    redirect_to root_path, notice: "Admin [ID: #{params[:admin_id]}] logado para o teste."
  end
end
