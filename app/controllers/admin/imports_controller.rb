module Admin
  class ImportsController < ApplicationController
    before_action :authenticate_admin!

    def import_sigaa
      uploaded_file = params[:arquivo]

      begin
        file_content = uploaded_file.read
        json_data = JSON.parse(file_content)

        Rails.logger.info("Iniciando importação de dados do SIGAA...")

        ActiveRecord::Base.transaction do
          if json_data.first&.key?('class') && json_data.first&.key?('code')
            Rails.logger.info("Detectado JSON de turmas")
            import_courses(json_data)
          elsif json_data.first&.key?('dicente') && json_data.first&.key?('code')
            Rails.logger.info("Detectado JSON de participantes")
            import_participants(json_data)
          else
            raise "Formato de arquivo não reconhecido."
          end
        end
        redirect_to importar_dados_path

      rescue => e
        redirect_to gerenciamento_path, alert: "Erro na importação: #{e.message}"
      end
    end




    private

    def import_courses(data)
      data.each do |course|
        Rails.logger.info("Importando curso: #{course['code']} - #{course['name']}")

        course_record = Course.find_or_create_by!(code: course['code']) do |c|
          c.name = course['name']
        end

        class_data = course['class']
        subject = Subject.find_or_create_by!(
          course: course_record,
          class_name: class_data['classCode'],
          semester: class_data['semester']
        ) do |s|
          s.schedule = class_data['time']
        end

        Rails.logger.info("Turma importada: #{subject.class_name} - Semestre: #{subject.semester}")
      end
    end

    def import_participants(data)
      data.each do |class_info|
        Rails.logger.info("Importando participantes para turma #{class_info['classCode']} - Semestre #{class_info['semester']}")

        subject = Subject.joins(:course)
                         .find_by!(
                           courses: { code: class_info['code'] },
                           class_name: class_info['classCode'],
                           semester: class_info['semester']
                         )

        class_info['dicente'].each do |student|
          Rails.logger.info("Importando estudante: #{student['nome']} - #{student['email']}")
          user = create_student(student)
          UserSubject.find_or_create_by!(user: user, subject: subject)
        end

        if class_info['docente']
          Rails.logger.info("Importando docente: #{class_info['docente']['nome']} - #{class_info['docente']['email']}")
          user = create_professor(class_info['docente'])
          UserSubject.find_or_create_by!(user: user, subject: subject)
        end
      end
    end

    def create_student(data)
      Rails.logger.info("Criando ou encontrando estudante com email: #{data['email']}")

      user = User.find_or_create_by!(email: data['email']) do |u|
        u.name = data['nome']
        u.username = data['usuario'] || data['matricula']
        u.role = :student
        u.academic_background = User.map_academic_background(data['formacao'])
        u.student_course = data['curso']
        u.student_enrolment = data['matricula']
        u.password_token = SecureRandom.urlsafe_base64(32)
        u.hash_password = BCrypt::Password.create(SecureRandom.hex(10))
      end


     #if user.password_defined_at.blank?
     # Rails.logger.info("Enviando link de definição de senha para estudante: #{user.email}")
      #  send_password_definition_email(user)
      
   # end
     enviar_email_definicao_senha(user)
      user
  end

    def create_professor(data)
      Rails.logger.info("Criando ou encontrando professor com email: #{data['email']}")

      user = User.find_or_create_by!(email: data['email']) do |u|
        u.name = data['nome']
        u.username = data['usuario']
        u.role = :professor
        u.academic_background = User.map_academic_background(data['formacao'])
        u.professor_departament = data['departamento']
        u.password_token = SecureRandom.urlsafe_base64(32)
        u.hash_password = BCrypt::Password.create(SecureRandom.hex(10))
      end

     # if user.password_defined_at.blank?
       # Rails.logger.info("Enviando link de definição de senha para professor: #{user.email}")
        #send_password_definition_email(user)
      #end
     enviar_email_definicao_senha(user)
      user
   end

    #def send_password_definition_email(user)
    #  token = user.password_token
     # url = Rails.application.routes.url_helpers.definir_senha_url(token: token, host: 'http://localhost:3000')
     # Rails.logger.info("🔑 Link de definição de senha para #{user.email}: #{url}")
     # puts "🔑 Link de definição de senha para #{user.email}: #{url}"
   # end
   def enviar_email_definicao_senha(user)
    return unless user.password_defined_at.blank?

    Rails.logger.info("Enviando link de definição de senha para #{user.email}")
    UsuarioMailer.definicao_senha_email(user).deliver_later # "deliver_now" para realizar testes em dev
  end


    def import_form
      # Apenas renderiza a view import.html.erb
    end

    def authenticate_admin!
      true
    end
  end
end
