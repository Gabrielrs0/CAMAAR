Dado("que estou logado como administrador") do
  @admin = User.create!(email: "admin@unb.br", password: "123456", role: "admin")
  login_as(@admin, scope: :user)
end

Quando("acesso a página de criação de template") do
  visit "/templates/new"
end

Quando("preencho o nome do template com {string}") do |nome|
  fill_in "Nome", with: nome
end

Quando("adiciono as perguntas {string} e {string}") do |pergunta1, pergunta2|
  fill_in "Pergunta 1", with: pergunta1
  fill_in "Pergunta 2", with: pergunta2
end

Quando("deixo o nome do template em branco") do
  fill_in "Nome", with: ""
end

Quando("clico em {string}") do |botao|
  click_button botao
end

Então("vejo a mensagem {string}") do |mensagem|
  expect(page).to have_content(mensagem)
end
