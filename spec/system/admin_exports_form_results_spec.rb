# spec/system/admin_exports_form_results_spec.rb
require 'rails_helper'

RSpec.describe 'Admin visualiza e exporta resultados de formulários', type: :system do
  # Usar let! garante que o admin seja criado antes do bloco 'before'.
  let!(:admin) { create(:admin) }
  let(:subject_instance) { create(:subject, class_name: 'Engenharia de Software') }
  let(:template) { create(:template, title: 'Avaliação Semestral') }

 # O formulário é criado dentro de cada teste para maior clareza.

 before do
  # Usamos a URL direta como string.
  # Isso bypassa o problema do helper de rota não ser encontrado.
  visit "/test/login/#{admin.id}"
end

  context 'Quando o formulário tem respostas' do
    it 'exibe os resultados e um link para exportar o CSV' do
      # --- Cenário ---
      form = create(:form, subject: subject_instance, template: template)
      user = create(:user, :aluno, name: 'Aluno Fulano')
      question = create(:question, template: template, content: 'Como avalia a disciplina?')
      create(:answer, form: form, user: user, question: question, answer_text: 'Excelente')

      # --- Execução ---
      # Agora que o login já foi feito, visitamos a página que queremos testar.
      visit admin_form_path(form)

      # --- Verificação ---
      expect(page).to have_content('Resultados do Formulário')
      expect(page).to have_content('Engenharia de Software')
      expect(page).to have_content('Aluno Fulano')
      expect(page).to have_content('Excelente')
      expect(page).to have_link('Exportar CSV', href: report_admin_form_path(form, format: :csv))
    end
  end

  context 'Quando o formulário não tem respostas' do
    it 'exibe uma mensagem indicando que não há respostas' do
      # --- Cenário ---
      form = create(:form, subject: subject_instance, template: template)

      # --- Execução ---
      visit admin_form_path(form)

      # --- Verificação ---
      expect(page).to have_content('Resultados do Formulário')
      expect(page).to have_content('Nenhuma resposta para este formulário ainda.')
      expect(page).to have_link('Exportar CSV', href: report_admin_form_path(form, format: :csv))
    end
  end

  context 'Ao tentar exportar um formulário sem respostas' do
  it 'redireciona de volta com uma mensagem de alerta' do
    # --- Cenário ---
    form = create(:form, subject: subject_instance, template: template)

    # --- Execução ---
    visit report_admin_form_path(form, format: :csv)

    # --- Verificação ---
    # 1. Verifica se a MENSAGEM de alerta que o controller enviou está na página.
    expect(page).to have_content('Não há respostas disponíveis para exportar')

    # 2. Verifica se a URL atual é a página de detalhes (show), para onde
    #    nós redirecionamos corretamente. ESTA É A CORREÇÃO.
    expect(page).to have_current_path(admin_form_path(form))
  end
  end
end
