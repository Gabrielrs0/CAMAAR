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

  has_many :user_subjects, dependent: :destroy
  has_many :subjects, through: :user_subjects

  has_many :answers, dependent: :destroy

  # Garante que o Usuário tenha nome, email, usuário, senha e cargo sejam não nulos
  validates :name, :email, :username, :hash_password, :role, presence: true
  # Garante que o email e o usuário sejam únicos
  validates :email, :username, uniqueness: true
  # Valida que o campo do professor está vazio se o usuário for um aluno, e que o campos relacionados ao discente não estejam vazios
  validates :professor_departament, absence: true, if: :aluno?
  validates :student_course, :student_enrolment, presence: true, if: :aluno?
  # Valida que os campos de aluno estão vazios se o usuário for um professor, e que o campos relacionados ao docente não estejam vazios
  validates :student_course, :student_enrolment, absence: true, if: :professor?
  # validates :student_enrolment, absence: true, if: :professor?
  validates :professor_departament, presence: true, if: :professor?
end
