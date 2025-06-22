# language: pt

Funcionalidade: Criar template de formulário

  Como administrador
  Quero criar um template de formulário com perguntas
  Para que eu possa utilizá-lo em formulários de avaliação

  Cenário: Caminho feliz - Template criado com sucesso
    Dado que estou logado como administrador
    Quando acesso a página de criação de template
    E preencho o nome do template com "Avaliação de Docente"
    E adiciono as perguntas "O docente foi claro?" e "O conteúdo foi adequado?"
    E clico em "Salvar"
    Então vejo a mensagem "Template criado com sucesso"
    E o novo template deve aparecer na lista de templates

  Cenário: Caminho triste - Tentativa de criar template sem nome
    Dado que estou logado como administrador
    Quando acesso a página de criação de template
    E deixo o nome do template em branco
    E clico em "Salvar"
    Então vejo a mensagem de erro "O nome do template é obrigatório"
