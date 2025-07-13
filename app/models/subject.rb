class Subject < ApplicationRecord
  belongs_to :course

  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects
  has_many :forms

  # Garante que turma, horário e semestre sejam não nulos
  validates :class_name, :schedule, :semester, presence: true
  # Garante que não haverá outra matéria com a mesma turma, horário e semestre.
  validates :class_name, uniqueness: {
    scope: [ :schedule, :semester ],
    message: "já existe com este horário e semestre."
  }

  # Garante que não haverá outra matéria com a mesma turma e semestre.
  validates :class_name, uniqueness: {
    scope: :semester,
    message: "já existe para este semestre."
  }
end
