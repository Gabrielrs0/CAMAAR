module Admin
# Namespace Admin: serviços administrativos do sistema
# Service PasswordDefinitionMailerService: envia e-mail de definição de senha para novos usuários
  class PasswordDefinitionMailerService
    include Callable

    # Inicializa o serviço de envio de e-mail de definição de senha
    # @param user [User] Usuário que receberá o e-mail
    def initialize(user)
      @user = user
    end

    # Envia o e-mail se o usuário ainda não definiu a senha
    # @return [void]
    # @note Usa deliver_later para enfileirar o e-mail
    def call
      return if @user.password_defined_at

      UsuarioMailer.definicao_senha_email(@user).deliver_now
    end
  end
end