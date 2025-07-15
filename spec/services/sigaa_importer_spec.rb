require 'rails_helper'

RSpec.describe "Importação SIGAA", type: :service do
  it "importa dados atomicamente" do
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
        "curso" => "Ciência da Computação",
        "matricula" => "123456",
        "usuario" => "ana.silva",
        "formacao" => "graduando",
        "email" => "ana@example.com"
      }]
    }]

    controller = Admin::ImportsController.new
    
    # Mock do método do User
    allow(User).to receive(:map_academic_background).and_return(:GRADUACAO_EM_ANDAMENTO)
    
    expect {
      controller.send(:import_courses, courses_data)
      controller.send(:import_participants, participants_data)
    }.to change(Course, :count).by(1)
     .and change(Subject, :count).by(1)
     .and change(User, :count).by(1)
  end
end