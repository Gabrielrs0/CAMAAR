class GerenciamentoController < ApplicationController
  before_action :authenticate_admin!

  def index
    @completed_steps = session[:completed_steps] || []
  end

  def importar_dados
    # aqui você chamaria o Admin::ImportsController indiretamente
    # ou moveria a lógica para um serviço e reutilizaria
    session[:completed_steps] = (@completed_steps || []) | ['importar_dados']
    redirect_to gerenciamento_path
  end

  def editar_templates
    session[:completed_steps] |= ['editar_templates']
    redirect_to gerenciamento_path
  end

  def enviar_formularios
    session[:completed_steps] |= ['enviar_formularios']
    redirect_to gerenciamento_path
  end

  def resultados
    session[:completed_steps] |= ['resultados']
    redirect_to gerenciamento_path
  end

  private

  def authenticate_admin!
    # Autenticação real
    true
  end
end
