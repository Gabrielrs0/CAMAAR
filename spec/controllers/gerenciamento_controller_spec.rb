require 'rails_helper'

RSpec.describe GerenciamentoController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_admin!).and_return(true)
  end

  describe "GET #index" do
    it "atribui @completed_steps com sessão" do
      session[:completed_steps] = ['step1']
      get :index
      expect(assigns(:completed_steps)).to eq(['step1'])
    end
  end

  describe "GET #importar_dados" do
    it "adiciona passo na sessão e redireciona" do
      get :importar_dados
      expect(session[:completed_steps]).to include("importar_dados")
      expect(response).to redirect_to(gerenciamento_path)
    end
  end

  describe "GET #editar_templates" do
    it "marca passo como completo e redireciona" do
      get :editar_templates
      expect(session[:completed_steps]).to include("editar_templates")
      expect(response).to redirect_to(gerenciamento_path)
    end
  end

  describe "POST #enviar_formularios" do
    it "marca passo como completo e redireciona" do
      post :enviar_formularios
      expect(session[:completed_steps]).to include("enviar_formularios")
      expect(response).to redirect_to(gerenciamento_path)
    end
  end

  describe "GET #resultados" do
    it "limpa a sessão e redireciona" do
      session[:completed_steps] = ['qualquer']
      get :resultados
      expect(session[:completed_steps]).to be_nil
      expect(response).to redirect_to(gerenciamento_path)
    end
  end
end
