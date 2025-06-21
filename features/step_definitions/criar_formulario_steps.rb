Given("existe um template chamado {string}") do |nome|
  Template.create!(nome: nome)
end

When("acesso a página de criação de formulário") do
  visit "/formularios/new"
end

When("seleciono o template {string}") do |nome|
  select nome, from: "Template"
end

When("escolho a turma {string}") do |turma|
  select turma, from: "Turmas"
end

When("deixo a turma em branco") do
  # Não selecionar nada
end
