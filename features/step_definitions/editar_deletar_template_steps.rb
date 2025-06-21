Given("existe um template chamado {string}") do |nome|
  @template = Template.create!(nome: nome)
end

Given("existe um template vinculado a formulários") do
  @template = Template.create!(nome: "Vinculado")
  Formulario.create!(template: @template, turma: "Turma X")
end

When("acesso a página de edição do template {string}") do |nome|
  visit "/templates/#{@template.id}/edit"
end

When("altero o nome para {string}") do |novo_nome|
  fill_in "Nome", with: novo_nome
end

When("tento deletar o template") do
  visit "/templates/#{@template.id}"
  click_button "Deletar"
end
