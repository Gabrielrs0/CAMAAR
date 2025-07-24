# Model Course: representa um curso com código e nome, possui várias turmas (subjects)
class Course < ApplicationRecord
  # Valida presença e unicidade do código e nome do curso
  # @return [void]
  validates :code, :name, presence: true, uniqueness: true

  # Garante tamanho exato de 7 caracteres para o código
  # @return [void]
  validates_length_of :code, is: 7

  has_many :subjects
end