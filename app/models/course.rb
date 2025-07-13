class Course < ApplicationRecord
  has_many :subjects

  validates :code, :name, presence: true, uniqueness: true
  validates_length_of :code, is: 7 # Garante que o código do curso tenha 7 caracteres; Ex: CIC0090 (CIC090 estaria errado)
end
