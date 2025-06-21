Given("estou autenticado no sistema") do
  @usuario = Usuario.create!(nome: "Weldo", email: "weldo@example.com", senha: "123456")
  login_as(@usuario)
end

Given("estou na página \"Avaliações\"") do
  visit "/formularios/avaliacoes"
end

When("o sistema carregar os formulários disponíveis") do
  # Simula carregamento automático
  # Pode envolver chamadas assíncronas via JS (use `using_wait_time` se necessário)
end

Then("devo ver apenas os formulários das turmas em que estou matriculado e ainda não respondi") do
  @turma = Turma.create!(nome: "Turma A")
  @formulario = Formulario.create!(titulo: "Avaliação Final", turma: @turma, respondido_por: [])
  visit "/formularios/avaliacoes"
  expect(page).to have_content("Avaliação Final")
  expect(page).to have_content("Turma A")
end

Then("cada cartão de formulário deve exibir o título, o nome da turma e a data de criação") do
  expect(page).to have_css(".formulario-card", minimum: 1)
  expect(page).to have_content("Avaliação Final")
  expect(page).to have_content("Turma A")
  expect(page).to have_content(@formulario.created_at.strftime("%d/%m/%Y"))
end

When("eu clicar em um dos formulários listados") do
  click_link "Avaliação Final"
end

Then("devo ser redirecionado para a página de resposta daquele formulário") do
  expect(page).to have_current_path(%r{/formularios/\d+/responder})
end

Given("todas as minhas turmas já foram avaliadas") do
  @turma = Turma.create!(nome: "Turma Avaliada")
  @formulario = Formulario.create!(titulo: "Formulário Concluído", turma: @turma, respondido_por: [@usuario])
end

Then("devo ver a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end

Given("ocorreu um erro na comunicação com o servidor") do
  allow(Formulario).to receive(:pendentes_para_usuario).and_raise(StandardError)
end

Given("o formulário já foi respondido") do
  @formulario = Formulario.create!(titulo: "Avaliação Respondida", respondido_por: [@usuario])
end

When("eu acessar a URL do formulário manualmente") do
  visit "/formularios/#{@formulario.id}/responder"
end