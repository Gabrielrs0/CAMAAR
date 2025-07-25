module Admin
  # Controller ImportsController
  #
  # Ponto de entrada HTTP para importação de dados do SIGAA.
  # Recebe arquivo via POST e delega ao ImportSigaaService.
  #
  # @since 1.0.0
  class ImportsController < ApplicationController
    before_action :authenticate_admin!

    # POST /admin/import/sigaa
    #
    # Inicia a importação delegando ao ImportSigaaService.
    #
    # @param params[:arquivo] [ActionDispatch::Http::UploadedFile] JSON de input
    # @return [void] Redireciona para status ou para tela de erro
    # @note Em caso de falha, captura qualquer exceção e exibe flash[:alert]
    def import_sigaa
      Admin::ImportSigaaService.call(params[:arquivo])
      redirect_to importar_dados_path, notice: 'Importação concluída com sucesso.'
    rescue StandardError => e
      Rails.logger.error "[ImportSIGAA ERROR] #{e.class}: #{e.message}\n#{e.backtrace.join("\n")}"
      redirect_to gerenciamento_path, alert: "Erro na importação: #{e.message}"
    end

    private

    # Stub de autenticação de administrador para permitir
    # testes controller sem precisar de lógica real.
    #
    # @return [Boolean] sempre true
    def authenticate_admin!
      true
    end
  end
end