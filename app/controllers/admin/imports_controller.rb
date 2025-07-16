# app/controllers/admin/imports_controller.rb
module Admin
  class ImportsController < ApplicationController
    before_action :authenticate_admin!

    def import_sigaa
  
      courses_data = JSON.parse(File.read(Rails.root.join('classes.json')))
      participants_data = JSON.parse(File.read(Rails.root.join('class_members.json')))

      # 2. Importação atômica
      ActiveRecord::Base.transaction do
        import_courses(courses_data)
        import_participants(participants_data)
      end

      redirect_to admin_dashboard_path, notice: 'Dados importados com sucesso!'
    rescue StandardError => e
      redirect_to admin_dashboard_path, alert: "Erro na importação: #{e.message}"
    end

    private

    def import_courses(data)
      data.each do |course|
        # Cria/atualiza matérias
        course_record = Course.find_or_create_by!(code: course['code']) do |c|
          c.name = course['name']
        end
        
        # Cria/atualiza turmas (Subjects)
        class_data = course['class']
        Subject.find_or_create_by!(
          course: course_record,
          class_name: class_data['classCode'],
          semester: class_data['semester']
        ) do |subject|
          subject.schedule = class_data['time']
        end
      end
    end

    def import_participants(data)
      data.each do |class_info|
        # Encontra a turma (Subject)
        subject = Subject.joins(:course)
                         .find_by!(
                           courses: { code: class_info['code'] },
                           class_name: class_info['classCode'],
                           semester: class_info['semester']
                         )

        # Importa estudantes (dicentes)
        class_info['dicente'].each do |student|
          user = create_student(student)
          UserSubject.find_or_create_by!(user: user, subject: subject)
        end

        # Importa professor (docente)
        if class_info['docente']
          user = create_professor(class_info['docente'])
          UserSubject.find_or_create_by!(user: user, subject: subject)
        end
      end
    end

 def create_student(data)
  User.find_or_create_by!(email: data['email']) do |user|
    user.name = data['nome']
    user.username = data['usuario'] || data['matricula']
    user.role = :student
    # Use o método do modelo User
    user.academic_background = User.map_academic_background(data['formacao'])
    user.student_course = data['curso']
    user.student_enrolment = data['matricula']
    user.hash_password = BCrypt::Password.create(SecureRandom.hex(10))
  end
end

def create_professor(data)
  User.find_or_create_by!(email: data['email']) do |user|
    user.name = data['nome']
    user.username = data['usuario']
    user.role = :professor
    # Use o método do modelo User
    user.academic_background = User.map_academic_background(data['formacao'])
    user.professor_departament = data['departamento']
    user.hash_password = BCrypt::Password.create(SecureRandom.hex(10))
  end
end
  def import_form
  # Apenas renderiza a view import.html.erb
  end


    def authenticate_admin!
      true
    end
  end
end