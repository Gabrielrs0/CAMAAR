Feature: Criar formulário a partir de template

  Cenário: Caminho feliz - Criar formulário com sucesso
    Dado que estou logado como administrador
    E existe um template chamado "Avaliação Semestral"
    Quando acesso a página de criação de formulário
    E seleciono o template "Avaliação Semestral"
    E escolho a turma "Cálculo I"
    E clico em "Criar"
    Então vejo a mensagem "Formulário criado com sucesso"

  Cenário: Caminho triste - Nenhuma turma selecionada
    Dado que estou logado como administrador
    E existe um template chamado "Avaliação Semestral"
    Quando acesso a página de criação de formulário
    E deixo a turma em branco
    E clico em "Criar"
    Então vejo a mensagem de erro "Selecione ao menos uma turma"
