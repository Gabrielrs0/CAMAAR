Given("estou na tela de {string} dentro do menu de gerenciamento") do |secao|
visit "/admin/gerenciamento"
click_button secao
end

Given("o formulário selecionado possui respostas preenchidas") do
@formulario = Formulario.create!(nome: "Formulário Avaliação", respondido: true)
end

When("clico no botão {string}") do |botao|
click_button botao
end

Then("devo baixar o arquivo {string}") do |nome_arquivo|
expect(page.response_headers['Content-Disposition']).to include(nome_arquivo)
end

Then("o conteúdo do arquivo deve conter os dados das respostas") do
conteudo = page.body
expect(conteudo).to include("Excelente", "Bom", "Regular") # exemplo de dados simulados
end

Given("existe um formulário sem nenhuma resposta") do
@formulario = Formulario.create!(nome: "Formulário Vazio", respondido: false)
end

When("acesso a página de resultados do formulário") do
visit "/admin/gerenciamento/resultados/#{@formulario.id}"
end

Then("devo ver uma mensagem de erro {string}") do |mensagem|
expect(page).to have_content(mensagem)
end

Then("o arquivo CSV não deve ser gerado") do
expect(page.response_headers['Content-Disposition']).to be_nil
end