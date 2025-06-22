Dado("tenho um template chamado {string}") do |nome|
  Template.create!(nome: nome)
end

Quando("acesso a criação de formulário") do
  visit "/formularios/new"
end

Quando("seleciono {string} como público-alvo") do |tipo|
  choose(tipo)
end

Quando("deixo o tipo de público em branco") do
  # não seleciona nada
end

Então("vejo a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end
