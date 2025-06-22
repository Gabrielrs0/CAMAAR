# language: pt

Funcionalidade: Responder formulário de avaliação
  Como um usuário do sistema
  Quero responder os formulários que me são enviados
  Para que eu possa avaliar as turmas em que estou matriculado

Cenário: Responder e enviar um formulário com todos os campos obrigatórios preenchidos (Happy Path)
  Dado que estou na página de um formulário de avaliação
  Quando eu preencher todas as perguntas obrigatórias
  E clicar no botão "Enviar"
  Então devo ver uma mensagem de sucesso "Formulário enviado com sucesso"
  E minhas respostas devem ser salvas no sistema

Cenário: Preencher respostas opcionais e enviar com sucesso (Happy Path)
  Dado que estou em um formulário com perguntas obrigatórias e opcionais
  Quando eu preencher todas as obrigatórias e também algumas opcionais
  E clicar no botão "Enviar"
  Então o envio deve ser concluído com sucesso
  E devo ver a confirmação na tela

Cenário: Tentar enviar o formulário sem responder perguntas obrigatórias (Sad Path)
  Dado que estou na página de um formulário de avaliação
  Quando eu deixar uma ou mais perguntas obrigatórias em branco
  E clicar no botão "Enviar"
  Então devo ver uma mensagem de erro "Responda todas as perguntas obrigatórias"

Cenário: Inserir texto inválido (muito longo) em uma resposta discursiva (Sad Path)
  Dado que estou em uma pergunta de texto aberto com limite de 300 caracteres
  Quando eu escrever uma resposta com mais de 300 caracteres
  E tentar enviar o formulário
  Então devo ver uma mensagem de erro "Resposta excede o limite permitido"

Cenário: Tentar enviar o formulário com campos com caracteres inválidos (Sad Path)
  Dado que estou respondendo um formulário
  Quando eu escrever símbolos não permitidos em uma resposta
  E clicar no botão "Enviar"
  Então devo ver uma mensagem "Resposta contém caracteres inválidos"

Cenário: Tentar reenviar um formulário já enviado (Sad Path)
  Dado que eu já enviei o formulário para uma determinada turma
  Quando eu tentar acessá-lo novamente
  Então devo ver uma mensagem "Você já respondeu este formulário"
  E o botão de envio deve estar desativado

Cenário: Perder conexão com a internet durante o envio (Sad Path)
  Dado que estou preenchendo um formulário
  Quando eu clicar em "Enviar" sem conexão com a internet
  Então devo ver uma mensagem "Não foi possível enviar. Verifique sua conexão e tente novamente"
  E nenhuma resposta deve ser enviada
