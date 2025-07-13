class Form < ApplicationRecord
  belongs_to :subject
  belongs_to :template

  has_many :user_forms, dependent: :destroy
  has_many :users, through: :user_forms
  has_many :answers, dependent: :destroy

  enum :receiver_role, {
    student: 0,
    professor: 1
  }

  validates :active_status, inclusion: {
    in: [ true, false ],
    message: "deve ser verdadeiro ou falso."
  }

  # Garante que o 'receiver_role' seja único para cada 'subject_id'.
  # Ou seja, uma matéria só pode ter um formulário para 'aluno' e um para 'professor'.
  validates :receiver_role, uniqueness: {
    scope: :subject_id,
    message: "já possui um formulário para este público (aluno/professor) nesta matéria."
  }
end
