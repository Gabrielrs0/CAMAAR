Given("existem templates cadastrados") do
  Template.create!(nome: "Avaliação Docente")
  Template.create!(nome: "Avaliação Discente")
end

Given("não existem templates cadastrados") do
  Template.delete_all
end

When("acesso a página de templates") do
  visit "/templates"
end

Then("vejo a lista com os templates disponíveis") do
  expect(page).to have_content("Avaliação Docente")
  expect(page).to have_content("Avaliação Discente")
end
