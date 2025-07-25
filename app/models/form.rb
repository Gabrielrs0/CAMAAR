# Model Form
# Representa um formulário atrelado a uma Disciplina (Subject) e um Template.
#
# Associations:
#   - belongs_to :subject
#   - belongs_to :template
#   - has_many   :user_forms, dependent: :destroy
#   - has_many   :users, through: :user_forms
#   - has_many   :answers, dependent: :destroy
#
# Enums:
#   receiver_role:
#     - student   => 0
#     - professor => 1
#
# Validations:
#   - active_status deve ser booleano (true/false)
#   - receiver_role deve ser único dentro do mesmo subject_id
class Form < ApplicationRecord
  belongs_to :subject
  belongs_to :template

  has_many :user_forms, dependent: :destroy
  has_many :users, through: :user_forms
  has_many :answers, dependent: :destroy

  enum receiver_role: {
    student:   0,
    professor: 1
  }

  # Garante que active_status seja booleano
  validates :active_status, inclusion: {
    in: [ true, false ],
    message: "deve ser verdadeiro ou falso."
  }

  # Garante um único formulário por receiver_role em cada disciplina
  validates :receiver_role, uniqueness: {
    scope:   :subject_id,
    message: "já possui um formulário para este público (aluno/professor) nesta matéria."
  }
end
