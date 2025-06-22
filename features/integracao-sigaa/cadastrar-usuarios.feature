# language: pt

Funcionalidade: Cadastrar usuários do sistema
    Eu como Administrador
    Quero cadastrar participantes de turmas do SIGAA ao importar dados de usuarios novos para o sistema
    A fim de que eles acessem o sistema CAMAAR

Cenário: Caminho feliz - Administrador importa dados de um novo participante com sucesso
    Dado que o Administrador está logado no sistema
    E existe um arquivo JSON com os dados dos participantes de uma turma do SIGAA
    E a participante com matrícula "190006" ainda não possui um usuário no sistema
    Quando o Administrador importa os dados do novo usuário "Ana Clara"
    Então o sistema deve criar um registro de usuário para "Ana Clara" com a matrícula "190006"
    E uma senha automática é gerada para o usuário
    E o cadastro do participante só é realmente efetivado após a definição da senha 
    E uma mensagem de "Usuários pré-cadastrados com sucesso. Aguardando definição de senha." deve ser exibida

Cenário: Caminho triste - Administrador tenta importar dados de um participante que já existe
    Dado que o Administrador está logado no sistema
    E existe um arquivo JSON com os dados dos participantes de uma turma do SIGAA
    E já existe um usuário cadastrado e ativo no sistema com a matrícula "190006"
    Quando o Administrador importa os dados do arquivo
    Então o sistema não deve criar um novo registro para o usuário com matrícula "190006"
    E uma mensagem de "Erro: O usuário com matrícula 190006 já está cadastrado." deve ser exibida