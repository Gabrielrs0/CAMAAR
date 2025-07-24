require 'rails_helper'

RSpec.describe Admin::ImportsController, type: :controller do
  describe "POST #import_sigaa" do
    let(:admin_user) { create(:user, role: :admin) }

    before do
      allow(controller).to receive(:authenticate_admin!).and_return(true)
    end

    context "com arquivo de turmas válido" do
      let(:valid_course_json) do
        [{
          "code": "MAT0025",
          "name": "CÁLCULO 1",
          "class": {
            "classCode": "A1",
            "semester": "2022.2",
            "time": "234M34"
          }
        }].to_json
      end

      it "importa os cursos e redireciona corretamente" do
        file = Tempfile.new("curso.json")
        file.write(valid_course_json)
        file.rewind

        post :import_sigaa, params: { arquivo: Rack::Test::UploadedFile.new(file.path, "application/json") }

        expect(response).to redirect_to(importar_dados_path)
      end
    end

    context "com arquivo inválido" do
      it "redireciona com alerta" do
        file = Tempfile.new("invalido.json")
        file.write("invalido")
        file.rewind

        post :import_sigaa, params: { arquivo: Rack::Test::UploadedFile.new(file.path, "application/json") }

        expect(response).to redirect_to(gerenciamento_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
