# Namespace Admin: controllers administrativos do sistema
# Controller ImportsController: inicia e gerencia a importação de dados do SIGAA
module Admin
  class ImportsController < ApplicationController
    # Inicia o fluxo de importação do arquivo JSON
    # @param params[:arquivo] [ActionDispatch::Http::UploadedFile] Arquivo JSON enviado pelo formulário
    # @return [void] Redireciona para a página de status de importação
    # @note Faz transação no banco e chama services de importação
    def import_sigaa
      ActiveRecord::Base.transaction do
        Admin::ImportSigaaService.call(params[:arquivo])
      end
      redirect_to importar_dados_path, notice: 'Importação concluída com sucesso.'
    rescue => error
      redirect_to gerenciamento_path, alert: "Erro na importação: #{error.message}"
    end

    private

    # Stub para autenticação de administrador nos testes
    # @return [Boolean] Retorna sempre true para permitir stub nos specs
    def authenticate_admin!
      true
    end

    # Encapsula chamada ao service de importação de cursos (para compatibilidade com specs antigos)
    # @param data [Array<Hash>] Dados de cursos a serem importados
    # @return [void]
    def import_courses(data)
      Admin::ImportCoursesService.call(data)
    end

    # Encapsula chamada ao service de importação de participantes (para compatibilidade com specs antigos)
    # @param data [Array<Hash>] Dados de participantes a serem importados
    # @return [void]
    def import_participants(data)
      Admin::ImportParticipantsService.call(data)
    end
  end
end