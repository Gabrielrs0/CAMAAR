Dado("existe um template chamado {string}") do |nome|
  Template.create!(nome: nome)
end

Quando("acesso a página de criação de formulário") do
  visit "/formularios/new"
end

Quando("seleciono o template {string}") do |nome|
  select nome, from: "Template"
end

Quando("escolho a turma {string}") do |turma|
  select turma, from: "Turmas"
end

Quando("deixo a turma em branco") do
  # Não selecionar nada
end
