Dado("existem templates cadastrados") do
  Template.create!(nome: "Avaliação Docente")
  Template.create!(nome: "Avaliação Discente")
end

Dado("não existem templates cadastrados") do
  Template.delete_all
end

Quando("acesso a página de templates") do
  visit "/templates"
end

Então("vejo a lista com os templates disponíveis") do
  expect(page).to have_content("Avaliação Docente")
  expect(page).to have_content("Avaliação Discente")
end
