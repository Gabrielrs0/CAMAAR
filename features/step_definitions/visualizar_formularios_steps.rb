Given("estou na tela de gerenciamento") do
visit "/admin/gerenciamento"
end

Then("devo ver uma lista de cartões com os formulários criados") do
expect(page).to have_css(".formulario-cartao", minimum: 1)
end

Then("cada cartão deve exibir o nome da matéria, semestre e professor") do
expect(page).to have_content("Estruturas de Dados")
expect(page).to have_content("2024.1")
expect(page).to have_content("Professor João")
end

Given("não há nenhum formulário criado") do
Formulario.destroy_all
end

Then("devo ver a mensagem {string}") do |mensagem|
expect(page).to have_content(mensagem)
end

Then("não devo ver nenhum cartão de formulário na tela") do
expect(page).not_to have_css(".formulario-cartao")
end