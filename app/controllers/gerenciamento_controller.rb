class GerenciamentoController < ApplicationController
  before_action :authenticate_admin!

  def index
    @completed_steps = session[:completed_steps] || []
  end

def importar_dados
  puts "[DEBUG] Entrou no importar_dados do GerenciamentoController"
  session[:completed_steps] ||= []
  session[:completed_steps] << "importar_dados" unless session[:completed_steps].include?("importar_dados")
  redirect_to gerenciamento_path
end

  def editar_templates
    session[:completed_steps] ||= []
    session[:completed_steps] << 'editar_templates' unless session[:completed_steps].include?('editar_templates')

    redirect_to gerenciamento_path
  end

  def enviar_formularios
    session[:completed_steps] ||= []
    session[:completed_steps] << 'enviar_formularios' unless session[:completed_steps].include?('enviar_formularios')
    redirect_to gerenciamento_path
  end

  def resultados
    #session[:completed_steps] ||= []
    session.delete(:completed_steps)
    logger.info ">>> Sessão resetada após resultados"
    redirect_to gerenciamento_path
  end



  private

  def authenticate_admin!
    # Autenticação real
    true
  end
end
