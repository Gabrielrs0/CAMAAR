# Model UserForm
# Representa a associação entre um Usuário e um Formulário, com status de preenchimento.
#
# Associations:
#   - belongs_to :user
#   - belongs_to :form
#
# Validations:
#   - Garante que cada par (user_id, form_id) seja único.
#
# Enums:
#   status:
#     - pendente      => 0
#     - em_andamento  => 1
#     - concluido     => 2
class UserForm < ApplicationRecord
  belongs_to :user
  belongs_to :form

  # Garante que um par de user/form seja único
  validates :user_id, uniqueness: { scope: :form_id }

  enum status: {
    pendente:      0,
    em_andamento:  1,
    concluido:     2
  }
end
