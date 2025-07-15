require 'rails_helper'

RSpec.describe Admin::ImportsController, type: :controller do
  describe "POST #import_sigaa" do
    context "com dados válidos" do
      it "importa cursos e participantes com sucesso" do
        # Mock de dados válidos
        courses_data = [{
          "code" => "CIC0097",
          "name" => "BANCOS DE DADOS",
          "class" => {
            "classCode" => "TA",
            "semester" => "2021.2",
            "time" => "35T45"
          }
        }]
        
        participants_data = [{
          "code" => "CIC0097",
          "classCode" => "TA",
          "semester" => "2021.2",
          "dicente" => [{
            "nome" => "Ana Silva",
            "curso" => "Engenharia",
            "matricula" => "123",
            "usuario" => "anasilva",
            "formacao" => "graduando",
            "email" => "ana@example.com"
          }]
        }]
        
        # Mock da leitura de arquivos
        allow(File).to receive(:read).and_return(
          courses_data.to_json, 
          participants_data.to_json
        )
        
        post :import_sigaa
        
        expect(response).to redirect_to(admin_dashboard_path)
        
      end
    end

    context "com dados inválidos" do
      it "falha com erro de sintaxe JSON" do
        # Mock de erro na leitura do JSON
        allow(File).to receive(:read).and_raise(JSON::ParserError.new("erro de sintaxe"))
        
        post :import_sigaa
        
        expect(response).to redirect_to(admin_dashboard_path)
        expect(flash[:alert]).to match(/Erro na importação/)
      end
    end
  end
end