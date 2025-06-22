
# language: pt

Funcionalidade: Criar formulário para docentes ou discentes

  Cenário: Caminho feliz - Criar formulário para docentes
    Dado que estou logado como administrador
    E tenho um template chamado "Template Docente"
    Quando acesso a criação de formulário
    E seleciono "Docente" como público-alvo
    E clico em "Criar"
    Então vejo a mensagem "Formulário criado para docentes"

  Cenário: Caminho triste - Tipo de público não selecionado
    Dado que estou logado como administrador
    Quando acesso a criação de formulário
    E deixo o tipo de público em branco
    E clico em "Criar"
    Então vejo a mensagem de erro "Selecione o público-alvo"
