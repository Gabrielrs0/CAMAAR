# language: pt

Funcionalidade: Gerar relatório de resultados
  Eu como Administrador
  Quero baixar um arquivo csv contendo os resultados de um formulário
  fim de avaliar o desempenho das turmas

Cenário: Caminho feliz - Exportar CSV com sucesso
  Dado que estou logado como administrador
  E estou na tela de "Resultados" dentro do menu de gerenciamento
  E o formulário selecionado possui respostas preenchidas
  Quando clico no botão "Exportar CSV"
  Então devo baixar o arquivo "resultados-formulario.csv"
  E o conteúdo do arquivo deve conter os dados das respostas

Cenário: Caminho triste - Tentativa de exportação sem respostas
  Dado que estou logado como administrador
  E existe um formulário sem nenhuma resposta
  Quando acesso a página de resultados do formulário
  E clico no botão "Exportar CSV"
  Então devo ver uma mensagem de erro "Não há respostas disponíveis para exportar"
  E o arquivo CSV não deve ser gerado
