
Given("estou na página de um formulário de avaliação") do
  @formulario = Formulario.create!(titulo: "Formulário Avaliação", respondido: false)
  visit "/formularios/#{@formulario.id}"
end

Given("estou em um formulário com perguntas obrigatórias e opcionais") do
  @formulario = Formulario.create!(titulo: "Formulário Completo", respondido: false)
  visit "/formularios/#{@formulario.id}"
end

When("eu preencher todas as perguntas obrigatórias") do
  fill_in "Pergunta 1", with: "Excelente"
  fill_in "Pergunta 2", with: "Sim"
end

When("eu preencher todas as obrigatórias e também algumas opcionais") do
  fill_in "Pergunta 1", with: "Excelente"
  fill_in "Pergunta 2", with: "Sim"
  fill_in "Comentário", with: "Ótima turma!"
end

When("clicar no botão {string}") do |botao|
  click_button botao
end

Then("devo ver uma mensagem de sucesso {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end

Then("minhas respostas devem ser salvas no sistema") do
  expect(@formulario.reload.respondido).to be true
end

Then("o envio deve ser concluído com sucesso") do
  expect(page).to have_current_path("/formularios/#{@formulario.id}/confirmacao")
end

Then("devo ver a confirmação na tela") do
  expect(page).to have_content("Obrigado por responder!")
end

When("eu deixar uma ou mais perguntas obrigatórias em branco") do
  fill_in "Pergunta 1", with: ""
  fill_in "Pergunta 2", with: ""
end

Then("devo ver uma mensagem de erro {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end

When("eu escrever uma resposta com mais de 300 caracteres") do
  texto_longo = "a" * 301
  fill_in "Comentário", with: texto_longo
end

When("eu escrever símbolos não permitidos em uma resposta") do
  fill_in "Comentário", with: "<script>alert('XSS')</script>"
end

Given("eu já enviei o formulário para uma determinada turma") do
  @formulario = Formulario.create!(titulo: "Formulário Finalizado", respondido: true)
end

When("eu tentar acessá-lo novamente") do
  visit "/formularios/#{@formulario.id}"
end

Then("o botão de envio deve estar desativado") do
  expect(page).to have_button("Enviar", disabled: true)
end

Given("estou preenchendo um formulário") do
  @formulario = Formulario.create!(titulo: "Formulário Online", respondido: false)
  visit "/formularios/#{@formulario.id}"
end

When("eu clicar em {string} sem conexão com a internet") do |botao|
  allow(Net::HTTP).to receive(:post).and_raise(SocketError)
  click_button botao
end

Then("nenhuma resposta deve ser enviada") do
  expect(@formulario.reload.respondido).to be false
end
