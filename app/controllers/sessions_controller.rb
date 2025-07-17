class SessionsController < ApplicationController
  
  def new
    render :new
  end

  #
  def create
    identifier = params[:session][:identifier]
    password = params[:session][:password]

    puts "-> identifier recebido: #{identifier.inspect}"
    puts "-> password recebido: #{password.inspect}"
    
    puts "-> sessao antes: #{session.to_hash.inspect}"
    # tenta encontrar o usuario pelo email
    user = User.find_by(email: identifier) ||
          User.find_by(student_enrolment: identifier)

    puts "-> user encontrado: #{user.inspect}"
    
    # Verifica se a senha é a mesma
    valid = user && user.hash_password == password
    puts "-> senha valida? #{valid}"

    if valid
      session[:user_id] = user.id
      puts "->session[:user_id] agr: #{session[:user_id]}"
      flash[:sucess] = "Login realizado com sucesso !" # Faz login com sucesso
      redirect_to root_path #VEFICAR SE ESTA ENCAMINHANDO PRO LUGAR CERTO
    else
      # Falha ao realizar o login
      flash.now[:alert] = "Email/matrícula ou senha inválidos"
      render 'new', status: :unauthorized
    end

  end

  def destroy
    # Sai da conta acessada e retorna para a pagina de login
    session.delete(:user_id)
    flash[:info] = "Você saiu do sistema Camaar!"
    redirect_to login_path #VEFICAR SE ESTA ENCAMINHANDO PRO LUGAR CERTO
  end
  
end
