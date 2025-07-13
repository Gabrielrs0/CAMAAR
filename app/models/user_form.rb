class UserForm < ApplicationRecord
  belongs_to :user
  belongs_to :form

  # Garante que um par de user/form seja único
  validates :user_id, uniqueness: { scope: :form_id }

  enum :status, {
    pendente: 0,
    em_andamento: 1,
    concluido: 2
  }
end
