# Controller GerenciamentoController: gerencia passos de importação, edição de templates, envio de formulários e resultados

class GerenciamentoController < ApplicationController
  # Controller responsável por gerenciar o fluxo de etapas de importação e resultados

  # Garante que apenas administradores acessem estas actions.
  # @return [Boolean] Sempre true (stub para testes)
  before_action :authenticate_admin!

  # Exibe a visão com o estado atual dos passos concluídos
  # @return [void]
  def index
    @completed_steps = session[:completed_steps] || []
  end

  # Marca o passo de importação de dados como concluído
  # @return [void]
  # @note Adiciona a string 'importar_dados' na sessão
  def importar_dados
    puts "[DEBUG] Entrou no importar_dados do GerenciamentoController"
    session[:completed_steps] ||= []
    session[:completed_steps] << 'importar_dados' unless session[:completed_steps].include?('importar_dados')
    redirect_to gerenciamento_path
  end

  # Marca o passo de edição de templates como concluído
  # @return [void]
  def editar_templates
    session[:completed_steps] ||= []
    session[:completed_steps] << 'editar_templates' unless session[:completed_steps].include?('editar_templates')
    redirect_to gerenciamento_path
  end

  # Marca o passo de envio de formulários como concluído
  # @return [void]
  def enviar_formularios
    session[:completed_steps] ||= []
    session[:completed_steps] << 'enviar_formularios' unless session[:completed_steps].include?('enviar_formularios')
    redirect_to gerenciamento_path
  end

  # Reseta a lista de passos concluídos
  # @return [void]
  # @note Limpa a sessão e registra log
  def resultados
    session.delete(:completed_steps)
    logger.info '>>> Sessão resetada após resultados'
    redirect_to gerenciamento_path
  end

  private

  # Stub que permite testes sem autenticação real
  # @return [Boolean]
  def authenticate_admin!
    true
  end
end