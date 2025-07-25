class SessionsController < ApplicationController
  # Renderiza a tela de login do usuário.
  #
  # @return [void]
  # @note apenas exibe o formulário de login
  def new
    render :new
  end

  # Controla o processo de login do usuário
  #
  # @return [void]
  # @note direciona o usuário para a página principal ou renderiza erro
  def create
    identifier = params[:session][:identifier]
    password = params[:session][:password]
    user = find_user(identifier)
    valid = is_valid_login(user, password)

    if valid
      sucess_login(user)
    else
      failed_login
    end
  end

  # Encerra a sessão do usuário ao realizar o logout.
  #
  # @return [void]
  # @note remove o ID do usuário em sessão, define mensagem de sucesso ao sair e redireciona para a página de login
  def destroy
    # Sai da conta acessada e retorna para a pagina de login
    session.delete(:user_id)
    flash[:info] = "Você saiu do sistema Camaar!"
    redirect_to login_path # VEFICAR SE ESTA ENCAMINHANDO PRO LUGAR CERTO
  end

  private

  # Tenta encontrar o usuário pelo identificador fornecido (email ou matrícula)
  #
  # @param identifier [String] identificador usado para autenticação
  # @return [User, nil] retorna ou o usuário encontrado ou nil
  def find_user(identifier)
    user = User.find_by(email: identifier) ||
          User.find_by(student_enrolment: identifier)
  end

  # Verifica se a combinação de usuário e senha é válida
  #
  # @param user [User] o usuário encontrado
  # @param password [String] senha fornecida
  # @return [Boolean] true se a senha for correta, false caso contrário
  def is_valid_login (user, password)
    valid = user && user.hash_password == password
  end

  # Realiza as ações de login bem-sucedido.
  #
  # @param user [User] usuário já autenticado
  # @return [void]
  # @note cria sessão, define flash de sucesso e redireciona
  def sucess_login (user)
      session[:user_id] = user.id
      flash[:sucess] = "Login realizado com sucesso !" # Faz login com sucesso
      redirect_to root_path # VEFICAR SE ESTA ENCAMINHANDO PRO LUGAR CERTO
  end

  # Exibe uma mensagem de erro e renderiza a tela de login.
  #
  # @return [void]
  # @note define flash de erro e renderiza :new
  def failed_login
    # Falha ao realizar o login
    flash.now[:alert] = "Email/matrícula ou senha inválidos"
    render "new", status: :unauthorized
  end
end
