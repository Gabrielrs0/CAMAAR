# Model Admin
# Representa um usuário administrador do sistema.
#
# Validations:
#   - username    deve estar presente e ser único
#   - hash_password deve estar presente
class Admin < ApplicationRecord
  validates :username,      presence: true, uniqueness: true
  validates :hash_password, presence: true
end
