# language: pt
Funcionalidade: usuario

eu como um usuario do site
gostaria de responder os formularios
que me sao enviados


Cenário 1:

Delineação do Cenário:
    -> realizar o login do usuario

    Dado que estou na pagina de login
    Quando eu preencher o campo de usuario e senha
    E clicar em Entrar
    Então devo acessar a pagina Avaliações
    Mas se as informaçoes estiverem erradas ou não preenchidas
    Então devo receber um aviso "não foi possivel realizar login"


Cenário 2:

Delineação do Cenário:
    -> acessar todos os formularios

    Dado que eu fiz o login em Cammar
    Quando eu clicar no botão sanduiche
    E clicar em "Avaliações"
    Então devo ver todos os <formularios> para responder


Cenário 3: 

Delineação do Cenário:
    -> acessar um formulario em específico

    Dado que vejo todos os <formularios> para responder
    Quando eu clicar em um dos <formularios> 
    Então poderei ver esse <formulario>


Cenário 4:

Delineação do cenário:
    -> responder e enviar o formulario acessado

    Dado que eu acessei um <formulario>
    Quando eu reponder esse <formulario>
    E eu clicar em enviar
    Então o <formulario> deve ser enviado ao remetente


Cenário 5:

Delineação do cenário:
    -> cancelar a resposta do formulario acessado

    Dado que eu acessei um <formulario>
    Quando eu clicar em cancelar
    Então eu devo retornar a pagina de Avaliações


Cenário 6:

Delineação do cenário:
    -> pesquisar formularios

    Dado que escrevi algo no campo de pesquisa
    Quando eu clicar Enter ou no simbolo da lupa
    Então deve aparecer os formularios relacionados


Cenário 7:

Delineação do cenário:
    -> sair da conta logada

    Dado que estou na pagina de Avaliações
    Quando eu clicar no simbolo do meu perfil
    E clicar em logout
    Então eu devo retornar a tela de login



