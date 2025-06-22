# language: pt

Funcionalidade: Visualizar templates

  Cenário: Caminho feliz - Ver lista de templates
    Dado que estou logado como administrador
    E existem templates cadastrados
    Quando acesso a página de templates
    Então vejo a lista com os templates disponíveis

  Cenário: Caminho triste - Nenhum template cadastrado
    Dado que estou logado como administrador
    E não existem templates cadastrados
    Quando acesso a página de templates
    Então vejo a mensagem "Nenhum template encontrado"