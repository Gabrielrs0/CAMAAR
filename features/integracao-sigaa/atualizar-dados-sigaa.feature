# language: pt

Funcionalidade: Atualizar base de dados com os dados do SIGAA
    Eu como Administrador
    Quero atualizar a base de dados já existente com os dados atuais do sigaa 
    A fim de corrigir a base de dados do sistema. 

Cenário: Caminho feliz - Administrador sincroniza a base de dados com o arquivo JSON
    Dado que o Administrador está logado no sistema
    E a base de dados do sistema contém uma turma obsoleta: código "CIC0090", turma "ZA"
    E o novo arquivo JSON do SIGAA contém uma nova turma: código "CIC0123", turma "AA"
    E o novo arquivo JSON do SIGAA não contém mais a turma "CIC0090", turma "ZA"
    Quando o Administrador executa a função para atualizar a base de dados
    Então o sistema deve adicionar a nova turma "CIC0123", turma "AA", à base de dados
    E o sistema deve remover a turma obsoleta "CIC0090", turma "ZA", da base de dados
    E uma mensagem de "Sincronização concluída. Base de dados corrigida com sucesso." deve ser exibida

Cenário: Caminho triste - Administrador tenta atualizar com um arquivo JSON vazio
    Dado que o Administrador está logado no sistema
    E a base de dados do sistema contém dados de 15 turmas ativas
    E o Administrador seleciona um arquivo JSON do SIGAA que está vazio
    Quando o Administrador executa a função para atualizar a base de dados
    Então o sistema não deve realizar alterações na base de dados
    E uma mensagem de "Erro: O arquivo de atualização está vazio ou é inválido. Nenhuma alteração foi feita." deve ser exibida