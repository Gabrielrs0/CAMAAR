# encoding: utf-8

# language: pt

# ------------ Passos para: Autenticação de Usuário no Sistema ------------

Dado('que existe um usuário {string} cadastrado com o e-mail {string} e senha {string}') do |tipo_usuario, email, senha|
  # TODO: Implementar a criação de um usuário com e-mail e senha.
  # O tipo_usuario ('Admin' ou 'Participante') pode ser usado para definir o papel.
  # Ex: @user = FactoryBot.create(:user, :admin, email: email, password: senha)
  puts "Pré-condição: Usuário #{tipo_usuario} com e-mail #{email} existe."
end

Dado('que existe um usuário {string} cadastrado com a matrícula {string} e senha {string}') do |tipo_usuario, matricula, senha|
  # TODO: Implementar a criação de um usuário com matrícula e senha.
  # Ex: @user = FactoryBot.create(:user, matricula: matricula, password: senha)
  puts "Pré-condição: Usuário #{tipo_usuario} com matrícula #{matricula} existe."
end

Dado('este usuário possui permissões de Administrador') do
  # TODO: Garantir que o usuário criado no passo anterior tenha o papel de admin.
  # Ex: @user.add_role(:admin)
  puts "Pré-condição: O usuário é um Administrador."
end

Dado('este usuário não possui permissões de Administrador') do
  # TODO: Garantir que o usuário criado não tenha o papel de admin.
  # Ex: @user.remove_role(:admin)
  puts "Pré-condição: O usuário não é um Administrador."
end

Dado('que o usuário está na página de login') do
  # TODO: Navegar para a página de login.
  # Ex: visit '/login'
  puts "Pré-condição: Usuário na página de login."
end

Quando('o usuário insere o e-mail {string} e a senha {string}') do |email, senha|
  # TODO: Preencher os campos de login com e-mail e senha.
  # Ex: fill_in 'Email ou Matrícula', with: email
  # fill_in 'Senha', with: senha
  puts "Ação: Insere e-mail #{email} e senha."
end

Quando('o usuário insere a matrícula {string} e a senha {string}') do |matricula, senha|
  # TODO: Preencher os campos de login com matrícula e senha.
  # Ex: fill_in 'Email ou Matrícula', with: matricula
  # fill_in 'Senha', with: senha
  puts "Ação: Insere matrícula #{matricula} e senha."
end

Quando('clica no botão {string}') do |nome_botao|
  # TODO: Clicar no botão especificado.
  # Ex: click_button nome_botao
  puts "Ação: Clica no botão '#{nome_botao}'."
end

Então('o usuário deve ser autenticado com sucesso') do
  # TODO: Verificar se o login foi bem-sucedido.
  # Pode ser checando a URL de destino ou um elemento da página principal.
  # Ex: expect(page).to have_current_path('/dashboard')
  puts "Verificação: Usuário autenticado."
end

Então('o menu lateral deve exibir a opção de {string}') do |opcao_menu|
  # TODO: Verificar a presença de um item no menu.
  # Ex: within('.menu-lateral') { expect(page).to have_content(opcao_menu) }
  puts "Verificação: Menu exibe a opção '#{opcao_menu}'."
end

Então('ser redirecionado para a sua página principal') do
  # TODO: Verificar se a URL atual é a da página principal do participante.
  # Ex: expect(page).to have_current_path('/formularios')
  puts "Verificação: Redirecionado para a página principal."
end

Então('o menu lateral não deve exibir a opção de {string}') do |opcao_menu|
  # TODO: Verificar a ausência de um item no menu.
  # Ex: within('.menu-lateral') { expect(page).not_to have_content(opcao_menu) }
  puts "Verificação: Menu não exibe a opção '#{opcao_menu}'."
end

Então('o usuário não deve ser autenticado') do
  # TODO: Verificar que a autenticação falhou.
  # Geralmente, significa permanecer na mesma página de login.
  # Ex: expect(page).to have_current_path('/login')
  puts "Verificação: Usuário não foi autenticado."
end

Então('uma mensagem de {string} deve ser exibida na tela') do |mensagem|
  # TODO: Verificar a presença da mensagem de erro.
  # Ex: expect(page).to have_content(mensagem)
  puts "Verificação: Mensagem '#{mensagem}' foi exibida."
end


# ------------ Passos para: Definição de Senha de Acesso ------------

Dado('que um usuário foi pré-cadastrado e recebeu um link válido para definição de senha') do
  # TODO: Criar um usuário com status 'pendente' e gerar um token válido.
  # @user = FactoryBot.create(:user, :pendente)
  # @token = @user.generate_password_token
  puts "Pré-condição: Usuário pendente com token de senha válido."
end

Dado('que o usuário está na página de {string} através de um link válido') do |nome_pagina|
  # TODO: Navegar para a página de definição de senha com um token válido.
  # @user = FactoryBot.create(:user, :pendente)
  # @token = @user.generate_password_token
  # visit "/definir-senha?token=#{@token}"
  puts "Pré-condição: Usuário na página '#{nome_pagina}' com link válido."
end

Dado('que um usuário possui um link para definição de senha que já foi utilizado ou expirou') do
  # TODO: Gerar um token e invalidá-lo (seja por uso ou por tempo).
  # @token = 'token_invalido_ou_expirado'
  puts "Pré-condição: Usuário possui um token inválido."
end

Quando('o usuário acessa a página através do link de definição de senha') do
  # TODO: Simular a visita à URL com o token gerado no passo 'Dado'.
  # Ex: visit "/definir-senha?token=#{@token}"
  puts "Ação: Acessa a página de definição de senha."
end

Quando('o usuário tenta acessar a página através deste link inválido') do
  # TODO: Simular a visita à URL com o token inválido.
  # Ex: visit "/definir-senha?token=#{@token}"
  puts "Ação: Acessa a página com link inválido."
end

Quando('preenche o campo {string} com {string}') do |nome_campo, valor|
  # TODO: Preencher o campo de senha especificado.
  # Ex: fill_in nome_campo, with: valor
  puts "Ação: Preenche o campo '#{nome_campo}'."
end

Então('o sistema deve salvar a nova senha para o usuário') do
  # TODO: Verificar no banco de dados se a senha do usuário foi atualizada.
  # @user.reload
  # expect(@user.valid_password?('SenhaSegura2025!')).to be true
  puts "Verificação: Nova senha foi salva no sistema."
end

Então('o cadastro do usuário deve ser efetivado no sistema') do
  # TODO: Verificar se o status do usuário mudou para 'ativo'.
  # expect(@user.reload.status).to eq('ATIVO')
  puts "Verificação: Cadastro do usuário foi efetivado."
end

Então('o usuário deve ser redirecionado para a página de login com uma mensagem de sucesso') do
  # TODO: Verificar o redirecionamento e a mensagem de flash.
  # expect(page).to have_current_path('/login')
  # expect(page).to have_content('Senha definida com sucesso! Você já pode fazer o login.')
  puts "Verificação: Redirecionado para o login com mensagem de sucesso."
end

Então('a senha do usuário não deve ser alterada') do
  # TODO: Verificar no banco de dados que a senha permanece a mesma (ou nula).
  # @user.reload
  # expect(@user.encrypted_password).to be_blank # Ou igual ao valor antigo
  puts "Verificação: A senha não foi alterada."
end

Então('uma mensagem de erro {string} deve ser exibida') do |mensagem_erro|
  # TODO: Verificar a mensagem de erro específica na página.
  # expect(page).to have_content(mensagem_erro)
  puts "Verificação: Mensagem de erro '#{mensagem_erro}' foi exibida."
end

Então('o sistema deve apresentar uma página de erro') do
  # TODO: Verificar se a página atual é uma página de erro designada.
  # expect(page).to have_current_path('/link-invalido')
  puts "Verificação: Página de erro foi apresentada."
end

Então('exibir a mensagem {string}') do |mensagem|
  # TODO: Verificar a presença da mensagem na página de erro.
  # expect(page).to have_content(mensagem)
  puts "Verificação: Mensagem '#{mensagem}' foi exibida."
end
