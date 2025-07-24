# Model Subject: representa uma turma/disciplina associada a um curso
class Subject < ApplicationRecord
  belongs_to :course
  has_many   :user_subjects, dependent: :destroy
  has_many   :users, through: :user_subjects
  has_many   :forms

  # Valida presença de nome da turma, horário e semestre
  # @return [void]
  validates :class_name, :schedule, :semester, presence: true
end