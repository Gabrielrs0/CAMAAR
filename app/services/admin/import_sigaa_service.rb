
# Namespace Admin: serviços administrativos do sistema
# Service ImportSigaaService: coordena importação de dados do SIGAA (cursos e participantes)
module Admin
  class ImportSigaaService
    include Callable

    # Inicializa o serviço de importação SIGAA.
    # @param uploaded_file [ActionDispatch::Http::UploadedFile] Arquivo JSON de input
    # @return [void] Dispara transação e encaminha para serviços específicos
    # @raise [RuntimeError] Quando o formato do JSON é desconhecido
    # @note Faz parse do JSON e delega para ImportCoursesService ou ImportParticipantsService
    def initialize(uploaded_file)
      @uploaded_file = uploaded_file
    end

    # Executa o fluxo de importação de dados.
    # @return [void]
    def call
      data = parse_json(@uploaded_file)
      Rails.logger.info("Iniciando importação de dados do SIGAA...")

      ActiveRecord::Base.transaction do
        if data.first.key?('class') && data.first.key?('code')
          Admin::ImportCoursesService.call(data)
        elsif data.first.key?('dicente') && data.first.key?('code')
          Admin::ImportParticipantsService.call(data)
        else
          raise "Formato de arquivo não reconhecido."
        end
      end
    end

    private

    # Faz o parse do conteúdo do arquivo para JSON.
    # @param file [ActionDispatch::Http::UploadedFile]
    # @return [Array<Hash>] Array de hashes representando o JSON
    def parse_json(file)
      JSON.parse(file.read)
    end
  end
end