# language: pt

Funcionalidade: Definição de Senha de Acesso
    Eu como Usuário
    Quero definir uma senha para o meu usuário a partir do e--mail do sistema de solicitação de cadastro
    A fim de acessar o sistema

Cenário: Caminho feliz - Usuário faz o login com link válido
    Dado que um usuário foi pré-cadastrado e recebeu um link válido para definição de senha
    Quando o usuário acessa o login
    E preenche o campo "Usuario" com sua matricula
    E preenche o campo "Senha" com a senha passada no link
    Então o sistema deve redirecionar para a mudança de senha

Cenário: Caminho feliz - Usuário define a senha com sucesso através de um link válido
    Dado que o cenário "Usuário faz o login com link válido" finalizou com sucesso
    Quando o usuário acessa a mudança de senha
    E preenche o campo "Nova Senha" com "SenhaSegura2025!"
    E preenche o campo "Confirmar Senha" com "SenhaSegura2025!"
    E clica no botão "Definir Senha"
    Então o sistema deve salvar a nova senha para o usuário
    E o cadastro do usuário deve ser efetivado no sistema 
    E o usuário deve ser redirecionado para a página de login com uma mensagem de sucesso

Cenário: Caminho triste - Usuário tenta definir uma senha, mas os campos não coincidem
    Dado que o cenário "Usuário faz o login com link válido" finalizou com sucesso
    Quando o usuário preenche o campo "Nova Senha" com "senha-valida"
    E preenche o campo "Confirmar Senha" com "senha-diferente"
    E clica no botão "Definir Senha"
    Então a senha do usuário não deve ser alterada
    E uma mensagem de erro "As senhas não coincidem. Tente novamente." deve ser exibida

Cenário: Caminho triste - Usuário tenta usar um link de definição de senha que é inválido ou já foi usado
    Dado que um usuário possui um link para definição de senha que já foi utilizado ou expirou
    Quando o usuário tenta acessar a página através deste link inválido
    Então o sistema deve apresentar uma página de erro
    E exibir a mensagem "Link inválido ou expirado. Por favor, entre em contato com o administrador."