module Admin
# Namespace Admin: serviços administrativos do sistema
# Service DefinePasswordService: aplica nova senha ao usuário e marca timestamp
  class DefinePasswordService
    include Callable

    # Inicializa o serviço de definição de senha
    # @param user [User] Usuário que receberá a senha
    # @param new_password [String] Nova senha em texto puro
    def initialize(user, new_password)
      @user         = user
      @new_password = new_password
    end

    # Atualiza o hash e marca timestamp de definição
    # @return [void]
    # @note Persiste as mudanças no banco
    def call
      @user.hash_password        = BCrypt::Password.create(@new_password)
      @user.password_defined_at  = Time.current
      @user.save!
    end
  end
end