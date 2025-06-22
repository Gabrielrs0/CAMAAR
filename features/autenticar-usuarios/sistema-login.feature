# language: pt

Funcionalidade: Autenticação de Usuário no Sistema
    Eu como Usuário do sistema
    Quero acessar o sistema utilizando um e-mail ou matrícula e uma senha já cadastrada
    A fim de responder formulários ou gerenciar o sistema 

Cenário: Caminho feliz - Usuário administrador efetua login e vê menu de gerenciamento
    Dado que existe um usuário "Admin" cadastrado com o e-mail "admin@camaar.com" e senha "adminpass"
    E este usuário possui permissões de Administrador
    Quando o usuário insere o e-mail "admin@camaar.com" e a senha "adminpass"
    E clica no botão "Entrar"
    Então o usuário deve ser autenticado com sucesso
    E o menu lateral deve exibir a opção de "Gerenciamento" 

Cenário: Caminho feliz - Usuário participante efetua login com sucesso
    Dado que existe um usuário "Participante" cadastrado com a matrícula "200032" e senha "senhaforte123"
    E este usuário não possui permissões de Administrador
    Quando o usuário insere a matrícula "200032" e a senha "senhaforte123"
    E clica no botão "Entrar"
    Então o usuário deve ser autenticado com sucesso
    E ser redirecionado para a sua página principal
    E o menu lateral não deve exibir a opção de "Gerenciamento"

Cenário: Caminho triste - Usuário tenta efetuar login com credenciais inválidas
    Dado que o usuário está na página de login
    Quando o usuário insere a matrícula "usuario.inexistente" e a senha "qualquersenha"
    E clica no botão "Entrar"
    Então o usuário não deve ser autenticado
    E uma mensagem de "Matrícula/e-mail ou senha inválidos." deve ser exibida na tela

Cenário: Caminho triste - Usuário tenta efetuar login com campos vazios
    Dado que o usuário está na página de login
    Quando o usuário insere a matrícula "" e a senha ""
    E clica no botão "Entrar"
    Então o usuário não deve ser autenticado
    E uma mensagem de "Digite um usuário e senha válidos" deve ser exibida na tela