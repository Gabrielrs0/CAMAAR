class Subject < ApplicationRecord
  belongs_to :course

  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects
  has_many :forms

  # Garante que turma, horário e semestre sejam não nulos
  validates :class_name, :schedule, :semester, presence: true

end
