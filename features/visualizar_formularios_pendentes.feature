# language: pt

Funcionalidade: Visualizar formulários pendentes de resposta
  Como Participante de uma turma
  Quero visualizar os formulários não respondidos das turmas em que estou matriculado
  A fim de poder escolher qual irei responder

Cenário: Listar apenas os formulários não respondidos (Happy Path)
  Dado que estou autenticado no sistema
  E estou na página "Avaliações"
  Quando o sistema carregar os formulários disponíveis
  Então devo ver apenas os formulários das turmas em que estou matriculado e ainda não respondi

Cenário: Formulários exibem título, nome da turma e data de criação (Happy Path)
  Dado que existem formulários pendentes para minha turma
  Quando eu estiver na página "Avaliações"
  Então cada cartão de formulário deve exibir o título, o nome da turma e a data de criação

Cenário: Acessar um formulário a partir da listagem (Happy Path)
  Dado que vejo a lista de formulários pendentes
  Quando eu clicar em um dos formulários listados
  Então devo ser redirecionado para a página de resposta daquele formulário

Cenário: Nenhum formulário pendente (Sad Path)
  Dado que todas as minhas turmas já foram avaliadas
  Quando eu acessar a página "Avaliações"
  Então devo ver a mensagem "Nenhum formulário pendente de resposta"

Cenário: Erro ao carregar formulários (Sad Path)
  Dado que ocorreu um erro na comunicação com o servidor
  Quando eu acessar a página "Avaliações"
  Então devo ver a mensagem "Erro ao carregar formulários. Tente novamente mais tarde"

Cenário: Tentativa de acessar formulário já respondido via URL direta (Sad Path)
  Dado que o formulário já foi respondido
  Quando eu acessar a URL do formulário manualmente
  Então devo ver uma mensagem "Você já respondeu este formulário"
