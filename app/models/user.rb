
# Representa um usuário do sistema Camaar
#
# Um usuário pode ser estudante ou professor, possui diversas associações e validações
# conforme seu perfil. Essa classe inclui enumerações para cargo e formação acadêmica,
# além de regras de consistência para os dados
# @example professor não possui matrícula, logo
#   student_enrolment, absence: true
class User < ApplicationRecord
  # Define os tipos de cargo disponíveis do usuário.
  #
  # @example verifica se o usuário é professor
  #   user.professor?
  enum :role, {
    aluno: 0,
    professor: 1
  }

  # @!attribute [rw] academic_background
  #   Define os níveis de formação acadêmica disponíveis para o usuário.
  #
  #   @example verifica qual a formaçao do usuário
  #     user.formacao?
  enum :academic_background, {
    GRADUACAO_EM_ANDAMENTO: 0,
    MESTRADO_EM_ANDAMENTO: 1,
    DOUTORADO_EM_ANDAMENTO: 2,
    GRADUACAO_CONCLUIDA: 3,
    MESTRADO_CONCLUIDO: 4,
    DOUTORADO_CONCLUIDO: 5
  }

  # Associação relacionamento entre usuários e disciplinas.
  #
  # @return [ActiveRecord::Relation] os relacionamentos do usuário com as disciplinas
  has_many :user_subjects, dependent: :destroy
  # Associação relacionamento disciplinas e usuário.
  #
  # @return [ActiveRecord::Relation] as disciplinas vinculadas ao usuário
  has_many :subjects, through: :user_subjects
  # Associação com as respostas do usuário.
  #
  # @return [ActiveRecord::Relation] as respostas do usuário
  has_many :answers, dependent: :destroy

  # Garante que o Usuário tenha nome, email, usuário, senha e cargo sejam não nulos
  validates :name, :email, :username, :hash_password, :role, presence: true
  # Garante que o email e o usuário sejam únicos
  validates :email, :username, uniqueness: true

  # Valida que o campo do professor está vazio se o usuário for um aluno,
  # e que o campos relacionados ao discente não estejam vazios
  validates :professor_departament, absence: true, if: :student?
  validates :student_course, :student_enrolment, presence: true, if: :student?

  # Valida que os campos de aluno estão vazios se o usuário for um professor,
  # e que o campos relacionados ao docente não estejam vazios
  validates :student_course, :student_enrolment, absence: true, if: :professor?
  validates :professor_departament, presence: true, if: :professor?
end
