class SessionsController < ApplicationController
  
  def new
  end

  #
  def create
    identifier = params[:session][:identifier]
    password = params[:session][:password]

    # tenta encontrar o usuario pelo email
    user = User.find_by(email: identifier.downcase)

    # tenta encontrar por matricula
    if user.nil?
      student_record = User.find_by(student_enrolment: identifier)
      user = student_record.user if student_record
    end

    # Verifica se a senha é a mesma
    if user && user.hash_password == password
      session[:user_id] = user.id
      # Faz login com sucesso
      flash[:sucess] = "Login realizado com sucesso !"
      redirect_to root_path #VEFICAR SE ESTA ENCAMINHANDO PRO LUGAR CERTO
    else
      # Falha ao realizar o login
      flash.now[:danger] = "Email/matrícula ou senha inválidos"
      render 'new', status: :unprocessable_entity
    end

  end

  def destroy
    # Sai da conta acessada e retorna para a pagina de login
    session[:user_id] = nil
    flash[:info] = "Você saiu do sistema Camaar!"
    redirect_to login_path #VEFICAR SE ESTA ENCAMINHANDO PRO LUGAR CERTO
  end
  
end
