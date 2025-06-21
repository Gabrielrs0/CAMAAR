Feature: Editar ou deletar template

  Cenário: Caminho feliz - Editar template com sucesso
    Dado que estou logado como administrador
    E existe um template chamado "Avaliação Antiga"
    Quando acesso a página de edição do template "Avaliação Antiga"
    E altero o nome para "Avaliação Atualizada"
    E clico em "Salvar"
    Então vejo a mensagem "Template atualizado com sucesso"

  Cenário: Caminho triste - Tentativa de deletar template vinculado
    Dado que estou logado como administrador
    E existe um template vinculado a formulários
    Quando tento deletar o template
    Então vejo a mensagem de erro "Não é possível deletar template vinculado a formulários"
