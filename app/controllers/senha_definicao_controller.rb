# Controller SenhaDefinicaoController: gerencia edição e atualização de senha via token

class SenhaDefinicaoController < ApplicationController
  # Exibe o formulário para definir nova senha.
  # @param params[:token] [String] Token de identificação do usuário
  # @return [void] Renderiza a view :edit ou redireciona em caso de token inválido
  # @note Redireciona com flash[:alert] quando o token é inválido ou já foi usado
  def edit
    @user = User.find_by(password_token: params[:token])
    if @user.nil? || @user.password_defined_at.present?
      redirect_to root_path, alert: 'Link inválido ou expirado.'
    end
  end

  # Processa definição de nova senha para o usuário.
  # @param params[:token] [String] Token de identificação do usuário
  # @param params[:password] [String] Nova senha definida pelo usuário
  # @return [void] Redireciona para root_path com flash[:notice] em caso de sucesso ou renderiza :edit em erro
  # @raise [ActiveRecord::RecordInvalid] Quando a persistência falha
  # @note Atualiza hash_password e password_defined_at no banco de dados
  def update
    @user = User.find_by(password_token: params[:token])
    unless @user
      redirect_to root_path, alert: 'Usuário não encontrado.' and return
    end

    if params[:password].blank?
      flash.now[:alert] = 'Senha não pode estar em branco.'
      render :edit
    else
      Admin::DefinePasswordService.call(@user, params[:password])
      redirect_to root_path, notice: 'Senha definida com sucesso!'
    end
  end
end