class SenhaDefinicaoController < ApplicationController
  def edit
    @user = User.find_by(password_token: params[:token])
    unless @user && @user.password_defined_at.blank?
      redirect_to root_path, alert: "Link inválido ou expirado."
    end
  end

  def update
    @user = User.find_by(password_token: params[:token])
    if @user.nil?
      redirect_to root_path, alert: "Usuário não encontrado."
    elsif params[:password].blank?
      flash.now[:alert] = "Senha não pode estar em branco."
      render :edit
    else
      @user.hash_password = BCrypt::Password.create(params[:password])
      @user.password_defined_at = Time.current
      @user.save!
      redirect_to root_path, notice: "Senha definida com sucesso!"
    end
  end
end
