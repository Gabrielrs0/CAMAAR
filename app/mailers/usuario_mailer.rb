class UsuarioMailer < ApplicationMailer
  default from: 'no-reply@suaapp.com' # personalize se quiser

  def definicao_senha_email(user)
    @user = user
    @token = user.password_token # ou como estiver salvo
    @url  = definir_senha_url(token: @token) # helper da rota

    mail(to: @user.email, subject: 'Defina sua senha')
  end
end
