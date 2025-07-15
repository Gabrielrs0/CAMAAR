require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validações" do
    context "Como estudante" do
      it "requer curso e matrícula" do
        user = User.new(
          name: 'Teste',
          email: 'teste@example.com',
          username: 'teste',
          hash_password: 'senha',
          role: :student
        )
        expect(user).not_to be_valid
        expect(user.errors[:student_course]).not_to be_empty
      end
    end

    context "Como professor" do
      it "requer departamento" do
        user = User.new(
          name: 'Professor',
          email: 'prof@example.com',
          username: 'prof',
          hash_password: 'senha',
          role: :professor
        )
        expect(user).not_to be_valid
        expect(user.errors[:professor_departament]).not_to be_empty
      end
    end
  end

  describe "Métodos de Classe" do
    it "mapeia formação acadêmica corretamente" do
      expect(User.map_academic_background('graduando')).to eq(:GRADUACAO_EM_ANDAMENTO)
      expect(User.map_academic_background('doutor')).to eq(:DOUTORADO_CONCLUIDO)
      expect(User.map_academic_background('desconhecido')).to eq(:GRADUACAO_EM_ANDAMENTO)
    end
  end
end