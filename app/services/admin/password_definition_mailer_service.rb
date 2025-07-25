module Admin
  # Service PasswordDefinitionMailerService
  #
  # Envia um e‑mail de definição de senha para usuários que ainda não
  # definiram sua senha.
  #
  # @example
  #   Admin::PasswordDefinitionMailerService.call(user)
  #
  # @since 1.0.0
  class PasswordDefinitionMailerService
    include Callable

    # Inicializa o serviço de envio de e‑mail de definição de senha.
    #
    # @param user [User] Usuário que receberá o e‑mail
    def initialize(user)
      @user = user
    end

    # Executa o envio do link de definição de senha.
    #
    # @return [void]
    # @note Não faz nada se o usuário já tiver definido a senha.
    def call
      return if @user.password_defined_at

      Rails.logger.info("Enviando link de definição de senha para #{@user.email}")
      UsuarioMailer.definicao_senha_email(@user).deliver_later
    end
  end
end

