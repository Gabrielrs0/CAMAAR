module Admin
  # Namespace Admin: serviços administrativos do sistema
# Service ImportCoursesService: importa turmas e matérias do JSON do SIGAA
  class ImportCoursesService
    include Callable

    # Inicializa o serviço de importação de cursos.
    # @param data [Array<Hash>] Dados de cursos vindos do JSON
    def initialize(data)
      @courses = data
    end

    # Percorre cada curso e o importa no banco.
    # @return [void]
    def call
      @courses.each do |course_data|
        code, name = course_data.values_at('code', 'name')
        Rails.logger.info("Importando curso: #{code} - #{name}")

        course = Course.find_or_create_by!(code: code) { |c| c.name = name }

        class_info = course_data['class']
        subject = Subject.find_or_create_by!(
          course: course,
          class_name: class_info['classCode'],
          semester: class_info['semester']
        ) { |s| s.schedule = class_info['time'] }

        Rails.logger.info("Turma importada: #{subject.class_name} - Semestre: #{subject.semester}")
      end
    end
  end
end