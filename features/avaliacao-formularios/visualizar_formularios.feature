# language: pt

Funcionalidade: Visualizar formulários criados
  Eu como Administrador
  Quero visualizar os formulários criados
  fim de poder gerar um relatório a partir das respostas

Cenário: Visualizar formulários no gerenciamento (Happy Path)
  Dado que estou logado como administrador
  E estou na tela de gerenciamento
  Quando clico no botão "Resultados"
  Então devo ver uma lista de cartões com os formulários criados
  E cada cartão deve exibir o nome da matéria, semestre e professor

Cenário:  Nenhum formulário criado (Sad Path)
  Dado que estou logado como administrador
  E não há nenhum formulário criado
  Quando clico em "Resultados" na tela de gerenciamento
  Então devo ver a mensagem "Nenhum formulário disponível"
  E não devo ver nenhum cartão de formulário na tela
