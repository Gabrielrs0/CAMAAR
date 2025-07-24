require 'rails_helper'

RSpec.describe SenhaDefinicaoController, type: :controller do
  let(:user) { create(:user, :student, password_token: "abc123", password_defined_at: nil) }

  describe "GET #edit" do
    context "quando o token é válido" do
      it "carrega o usuário corretamente e renderiza a view" do
        get :edit, params: { token: user.password_token }

        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end

    context "quando o token é inválido" do
      it "redireciona para a página inicial com alerta" do
        get :edit, params: { token: "token_invalido" }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Link inválido ou expirado.")
      end
    end
  end

  describe "PATCH #update" do
    context "quando a senha é válida" do
      it "atualiza a senha e redireciona com mensagem" do
        patch :update, params: { token: user.password_token, password: "novaSenha123" }

        user.reload
        expect(user.password_defined_at).to be_present
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Senha definida com sucesso!")
      end
    end

    context "quando a senha está em branco" do
      it "não atualiza a senha e renderiza o formulário com alerta" do
        patch :update, params: { token: user.password_token, password: "" }

        expect(response).to render_template(:edit)
        expect(flash[:alert]).to eq("Senha não pode estar em branco.")
      end
    end
  end
end
