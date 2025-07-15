class User < ApplicationRecord
  enum :role, {
    student: 0,
    professor: 1
  }
  enum :academic_background, {
    GRADUACAO_EM_ANDAMENTO: 0,
    MESTRADO_EM_ANDAMENTO: 1,
    DOUTORADO_EM_ANDAMENTO: 2,
    GRADUACAO_CONCLUIDA: 3,
    MESTRADO_CONCLUIDO: 4,
    DOUTORADO_CONCLUIDO: 5
  }

     def self.create_student(data)
    create!(
      name: data["nome"],
      email: data["email"],
      username: data["usuario"],
      academic_background: map_academic_background(data["formacao"]),
      student_course: data["curso"],
      student_enrolment: data["matricula"],
      role: 'student',
      hash_password: BCrypt::Password.create(SecureRandom.hex(10))
    )
  end

  def self.create_professor(data)
    create!(
      name: data["nome"],
      email: data["email"],
      username: data["usuario"],
      academic_background: map_academic_background(data["formacao"]),
      professor_departament: data["departamento"],
      role: 'professor',
      hash_password: BCrypt::Password.create(SecureRandom.hex(10))
    )
  end

   def self.map_academic_background(formacao)
    case formacao.downcase
    when 'graduando' then :GRADUACAO_EM_ANDAMENTO
    when 'mestrando' then :MESTRADO_EM_ANDAMENTO
    when 'doutorando' then :DOUTORADO_EM_ANDAMENTO
    when 'graduado' then :GRADUACAO_CONCLUIDA
    when 'mestre' then :MESTRADO_CONCLUIDO
    when 'doutor' then :DOUTORADO_CONCLUIDO
    else
      :GRADUACAO_EM_ANDAMENTO
    end
  end
  
  has_many :user_subjects, dependent: :destroy
  has_many :subjects, through: :user_subjects

  has_many :answers, dependent: :destroy

  # Garante que o Usuário tenha nome, email, usuário, senha e cargo sejam não nulos
  validates :name, :email, :username, :hash_password, :role, presence: true
  # Garante que o email e o usuário sejam únicos
  validates :email, :username, uniqueness: true
  # Valida que o campo do professor está vazio se o usuário for um aluno, e que o campos relacionados ao discente não estejam vazios
  validates :professor_departament, absence: true, if: :student?
  validates :student_course, :student_enrolment, presence: true, if: :student?
  # Valida que os campos de aluno estão vazios se o usuário for um professor, e que o campos relacionados ao docente não estejam vazios
  validates :student_course, :student_enrolment, absence: true, if: :professor?
  # validates :student_enrolment, absence: true, if: :professor?
  validates :professor_departament, presence: true, if: :professor?
end
