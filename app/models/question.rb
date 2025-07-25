# Model Question
# Representa uma pergunta pertencente a um Template.
#
# Associations:
#   - belongs_to :template
#   - has_many   :answers, dependent: :destroy
#
# Enums:
#   question_type:
#     - text         => 0
#     - alternative  => 1
#
# Validations:
#   - content deve estar presente
class Question < ApplicationRecord
  belongs_to :template
  has_many   :answers, dependent: :destroy

  enum question_type: {
    text:        0,
    alternative: 1
  }

  # Garante que a Pergunta tenha conteúdo não nulo
  validates :content, presence: true
end
