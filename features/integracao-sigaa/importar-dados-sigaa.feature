# language: pt

Funcionalidade: Importação de Dados do SIGAA
    Eu como Administrador
    Quero importar dados de turmas, matérias e participantes do SIGAA (caso não existam na base de dados atual)
    A fim de alimentar a base de dados do sistema.
    
    P.S. utilizar os JSONs presentes no repositório

Cenário: Caminho feliz - Administrador importa novos dados com sucesso
    Dado que o Administrador está logado no sistema
    E que existe um arquivo JSON "classes.json" no repositório contendo dados de novas turmas
    E que os dados do arquivo não existem na base de dados do sistema
    Quando o Administrador clica no botão "Importar Dados"
    Então o sistema deve processar o arquivo JSON
    E a base de dados deve ser alimentada com os novos dados de turmas, matérias e participantes
    E uma mensagem de "Importação concluída com sucesso" deve ser exibida

Cenário: Caminho triste - Administrador tenta importar dados que já existem no sistema
    Dado que o Administrador está logado no sistema
    E que existe um arquivo JSON "classes.json" no repositório
    E que os dados da turma com código "CIC0097" e semestre "2021.2" e turma "AA" já existem na base de dados
    Quando o Administrador clica no botão "Importar Dados"
    Então o sistema não deve adicionar os dados duplicados
    E uma mensagem de "Erro: Alguns dados já existem no sistema e não foram importados." deve ser exibida