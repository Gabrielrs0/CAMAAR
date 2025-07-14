# spec/system/admin_views_forms_spec.rb
require 'rails_helper'

RSpec.describe 'Admin visualiza formulários criados', type: :system do
  # Usar let! garante que o admin seja criado ANTES do bloco 'before'.
  let!(:admin) { create(:admin) }

  before do
    # ===================================================================
    # ## AQUI ESTÁ A CORREÇÃO ##
    #
    # Removemos a lógica antiga do :rack_test e usamos o mesmo método
    # de "backdoor" do outro teste, que funciona com o driver Selenium.
    visit "/test/login/#{admin.id}"
    # ===================================================================
  end

  context 'quando existem formulários criados' do
    it 'exibe os cartões dos formulários com informações da matéria, semestre e professor' do
      subject = create(:subject, class_name: 'Engenharia de Software', semester: '2024.1', schedule: 'Segunda 08:00')
      # Corrigindo a factory de professor para remover hash_password que não é um atributo padrão
      professor = create(:user, name: 'Prof. João', role: :professor, username: 'profjoao', professor_departament: 'Engenharia de Software', email: 'profjoao@example.com')
      subject.users << professor

      template = create(:template)
      form = create(:form, subject: subject, receiver_role: :aluno, template: template)
      # A associação do professor ao formulário também deve ser feita corretamente
      form.users << professor

      # O login já foi feito no 'before', agora visitamos a página do teste
      visit admin_forms_path

      expect(page).to have_content('Engenharia de Software')
      expect(page).to have_content('2024.1')
      expect(page).to have_content('Prof. João')
    end
  end

  context 'quando não existem formulários' do
    it 'exibe mensagem informando que não há formulários disponíveis' do
      # O login já foi feito no 'before'
      visit admin_forms_path

      expect(page).to have_content('Nenhum formulário disponível')
      expect(page).not_to have_css('.form-card')
    end
  end
end