module Admin
# Namespace Admin: serviços administrativos do sistema
# Service ImportParticipantsService: importa participantes (estudantes e professores) do JSON do SIGAA
module Admin
  class ImportParticipantsService
    include Callable

    # Inicializa o serviço de importação de participantes.
    # @param data [Array<Hash>] Dados de turmas e participantes
    def initialize(data)
      @classes = data
    end

    # Executa importações para cada turma.
    # @return [void]
    def call
      @classes.each { |class_info| import_for_class(class_info) }
    end

    private

    # Importa usuários de uma turma
    # @param info [Hash] Dados da turma e participantes
    # @return [void]
    def import_for_class(info)
      code, class_code, semester = info.values_at('code', 'classCode', 'semester')
      subject = Subject.joins(:course).find_by!(
        courses: { code: code }, class_name: class_code, semester: semester
      )

      import_students(info['dicente'], subject)
      import_professor(info['docente'], subject) if info['docente']
    end

    # Cria ou encontra cada estudante
    # @param students [Array<Hash>] Lista de atributos de estudantes
    # @param subject [Subject] Objeto de turma no banco
    # @return [void]
    def import_students(students, subject)
      students.each do |attrs|
        user = Admin::CreateUserService.call(attrs, :student)
        UserSubject.find_or_create_by!(user: user, subject: subject)
      end
    end

    # Cria ou encontra o professor
    # @param docente [Hash] Atributos do professor
    # @param subject [Subject]
    # @return [void]
    def import_professor(docente, subject)
      user = Admin::CreateUserService.call(docente, :professor)
      UserSubject.find_or_create_by!(user: user, subject: subject)
    end
  end
end