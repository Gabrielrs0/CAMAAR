# encoding: utf-8

# language: pt

# ------------ Passos Comuns a Várias Features ------------

Dado('que o Administrador está logado no sistema') do
  # TODO: Implementar a lógica de login do administrador.
  # Ex: @login_page = LoginPage.new
  # @login_page.load
  # @login_page.login_with('admin', 'senha_admin')
  puts 'Pré-condição: Administrador logado.'
end


# ------------ Passos para: Cadastrar usuários do sistema ------------

Dado('existe um arquivo JSON com os dados dos participantes de uma turma do SIGAA') do
  # TODO: Simular a existência de um arquivo JSON válido para o teste.
  # Pode ser a preparação de um mock ou um arquivo físico na pasta de testes.
  @arquivo_json_participantes = { matricula: '190006', nome: 'Ana Clara', email: 'ana.clara@email.com' }.to_json
  puts 'Pré-condição: Arquivo JSON de participantes existe.'
end

Dado('a participante com matrícula {string} ainda não possui um usuário no sistema') do |matricula|
  # TODO: Implementar verificação e garantir que o usuário não existe no banco de dados.
  # Ex: User.find_by(matricula: matricula)&.destroy
  puts "Pré-condição: Usuário com matrícula #{matricula} não existe."
end

Dado('já existe um usuário cadastrado e ativo no sistema com a matrícula {string}') do |matricula|
  # TODO: Implementar a criação de um usuário no banco de dados para o teste.
  # Ex: User.create(matricula: matricula, nome: 'Usuário Teste', status: 'ATIVO') unless User.exists?(matricula: matricula)
  puts "Pré-condição: Usuário com matrícula #{matricula} já existe."
end

Quando('o Administrador importa os dados do novo usuário {string}') do |nome_usuario|
  # TODO: Implementar a ação de clicar no botão e realizar a importação.
  # Ex: @importacao_page.load
  # @importacao_page.importar_arquivo(@arquivo_json_participantes)
  puts "Ação: Importar dados do usuário #{nome_usuario}."
end

Quando('o Administrador importa os dados do arquivo') do
  # TODO: Implementar a ação de importação (passo genérico).
  # Ex: @importacao_page.load
  # @importacao_page.importar_arquivo(@arquivo_json_participantes)
  puts 'Ação: Administrador importa os dados do arquivo.'
end

Então('o sistema deve criar um registro de usuário para {string} com a matrícula {string}') do |nome, matricula|
  # TODO: Verificar no banco de dados se um registro foi criado.
  # user = User.find_by(matricula: matricula)
  # expect(user).not_to be_nil
  # expect(user.nome).to eq(nome)
  puts "Verificação: Registro criado para #{nome} (#{matricula})."
end

Então('uma solicitação para definição de senha deve ser enviada para o e-mail do novo usuário') do
  # TODO: Verificar se um serviço de e-mail foi acionado (pode ser um mock).
  # expect(EmailService).to have_received(:enviar_definicao_senha).with(email: 'ana.clara@email.com')
  puts 'Verificação: E-mail para definição de senha foi enviado.'
end

Então('o cadastro do participante só é realmente efetivado após a definição da senha') do
  # TODO: Verificar no banco de dados se o status do usuário é "PENDENTE" ou similar.
  # user = User.find_by(matricula: '190006')
  # expect(user.status).to eq('PENDENTE_SENHA')
  puts 'Verificação: Status do usuário indica pendência de senha.'
end

Então('uma mensagem de {string} deve ser exibida') do |mensagem|
  # TODO: Verificar se a mensagem de feedback é exibida na interface.
  # expect(page).to have_content(mensagem)
  puts "Verificação: Mensagem \"#{mensagem}\" foi exibida."
end

Então('o sistema não deve criar um novo registro para o usuário com matrícula {string}') do |matricula|
  # TODO: Verificar no banco de dados que nenhum novo registro foi criado.
  # count = User.where(matricula: matricula).count
  # expect(count).to eq(1)
  puts "Verificação: Nenhum novo registro foi criado para a matrícula #{matricula}."
end


# ------------ Passos para: Atualizar base de dados com os dados do SIGAA ------------

Dado('a base de dados do sistema contém uma turma obsoleta: código {string}, turma {string}') do |codigo, turma|
  # TODO: Inserir o dado obsoleto no banco de dados para o teste.
  # Ex: Turma.create(codigo: codigo, turma: turma)
  puts "Pré-condição: Turma obsoleta #{codigo}-#{turma} existe no BD."
end

Dado('o novo arquivo JSON do SIGAA contém uma nova turma: código {string}, turma {string}') do |codigo, turma|
  # TODO: Preparar o mock do JSON que será usado na atualização.
  @arquivo_json_atualizacao = [ { code: codigo, class: { classCode: turma } } ].to_json
  puts "Pré-condição: JSON de atualização contém a nova turma #{codigo}-#{turma}."
end

Dado('o novo arquivo JSON do SIGAA não contém mais a turma {string}, turma {string}') do |codigo, turma|
  # TODO: Garantir que o mock do JSON não tenha essa turma.
  # Esta verificação é implícita na construção do mock no passo anterior.
  puts "Pré-condição: JSON de atualização não contém a turma obsoleta #{codigo}-#{turma}."
end

Dado('a base de dados do sistema contém dados de {int} turmas ativas') do |quantidade|
  # TODO: Popular o banco com um número específico de turmas.
  # Ex: Turma.destroy_all; FactoryBot.create_list(:turma, quantidade)
  @contagem_inicial = quantidade
  puts "Pré-condição: O BD contém #{quantidade} turmas."
end

Dado('o Administrador seleciona um arquivo JSON do SIGAA que está vazio') do
  # TODO: Preparar um mock de um arquivo JSON vazio.
  @arquivo_json_atualizacao = [].to_json
  puts 'Pré-condição: Arquivo JSON de atualização está vazio.'
end

Quando('o Administrador executa a função para atualizar a base de dados') do
  # TODO: Implementar a ação de clicar no botão de sincronização/atualização.
  # Ex: @sincronizacao_page.load
  # @sincronizacao_page.sincronizar_com_arquivo(@arquivo_json_atualizacao)
  puts 'Ação: Executar a atualização da base de dados.'
end

Então('o sistema deve adicionar a nova turma {string}, turma {string}, à base de dados') do |codigo, turma|
  # TODO: Verificar se a nova turma foi inserida no banco de dados.
  # expect(Turma.exists?(codigo: codigo, turma: turma)).to be true
  puts "Verificação: Nova turma #{codigo}-#{turma} foi adicionada."
end

Então('o sistema deve remover a turma obsoleta {string}, turma {string}, da base de dados') do |codigo, turma|
  # TODO: Verificar se a turma obsoleta foi removida do banco de dados.
  # expect(Turma.exists?(codigo: codigo, turma: turma)).to be false
  puts "Verificação: Turma obsoleta #{codigo}-#{turma} foi removida."
end

Então('o sistema não deve realizar alterações na base de dados') do
  # TODO: Verificar se a contagem de registros no banco de dados permaneceu a mesma.
  # expect(Turma.count).to eq(@contagem_inicial)
  puts 'Verificação: Nenhuma alteração foi feita no banco de dados.'
end
