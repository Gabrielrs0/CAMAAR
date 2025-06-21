Given("tenho um template chamado {string}") do |nome|
  Template.create!(nome: nome)
end

When("acesso a criação de formulário") do
  visit "/formularios/new"
end

When("seleciono {string} como público-alvo") do |tipo|
  choose(tipo)
end

When("deixo o tipo de público em branco") do
  # não seleciona nada
end

Then("vejo a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end
