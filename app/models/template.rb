# Model Template
# Representa um template de formulário, com título e conjunto de perguntas.
#
# Associations:
#   - has_many :questions
#   - has_one  :form
#
# Validations:
#   - title deve estar presente
class Template < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_one  :form, dependent: :destroy

  # Garante que o título esteja presente
  validates :title, presence: true
end
