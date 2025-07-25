module Admin
  # Service ImportSigaaService
  #
  # Coordena a importação, item a item, de um JSON do SIGAA,
  # delegando cada registro para ImportCoursesService ou
  # ImportParticipantsService conforme seu formato.
  #
  # @example
  #   Admin::ImportSigaaService.call(params[:arquivo])
  #
  # @since 1.0.0
  class ImportSigaaService
    include Callable

    # Inicializa o serviço de importação SIGAA.
    #
    # @param uploaded_file [ActionDispatch::Http::UploadedFile] Arquivo JSON enviado via formulário
    def initialize(uploaded_file)
      @uploaded_file = uploaded_file
    end

    # Executa o fluxo de importação de dados.
    #
    # Percorre cada entrada do JSON, verifica se é curso ou
    # participante e chama o service correspondente.
    #
    # @return [void]
    # @raise [RuntimeError] Se encontrar um item com formato desconhecido
    def call
      entries = parse_json(@uploaded_file)
      Rails.logger.info "Iniciando importação de dados do SIGAA..."

      ActiveRecord::Base.transaction do
        entries.each do |entry|
          if entry.key?('class') && entry.key?('code')
            Admin::ImportCoursesService.call([entry])
          elsif entry.key?('dicente') && entry.key?('code')
            Admin::ImportParticipantsService.call([entry])
          else
            raise "Formato de item não reconhecido: #{entry.inspect}"
          end
        end
      end
    end

    private

    # Lê todo o conteúdo do arquivo e faz parse para Array de Hashes.
    #
    # @param file [ActionDispatch::Http::UploadedFile]
    # @return [Array<Hash>] Representação Ruby do JSON
    # @raise [JSON::ParserError] Se o JSON estiver mal formado
    def parse_json(file)
      JSON.parse(file.read)
    end
  end
end