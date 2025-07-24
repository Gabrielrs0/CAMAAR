## Critérios de Refatoração

- Identificar os métodos com **ABC Score ≥ 20** (via RubyCritic/Flog).
- Refatorar todos os métodos com score ≥ 20 até que fiquem abaixo de 20.

| Nome da Controller                               | Score Anterior | Score Posterior | Refatoração Aplicada                                                                                   |
|--------------------------------------------------|:-------------:|:--------------:|:------------------------------------------------------------------------------------------------------|
| `app/controllers/admin/imports_controller.rb`    | total: 153.86 | total: 14.25   | Extrair lógica de importação em **services** (`ImportSigaaService`, `ImportCoursesService`, etc.)     |
| `app/controllers/senha_definicao_controller.rb`  | total: 28.74  | total: 8.00    | Mover lógica de definição de senha para `DefinePasswordService`; simplificar `update` e `edit`         |
| `app/controllers/gerenciamento_controller.rb`    | total: 42.62  | total: 11.42   | Unificar marcação de passos em métodos privados e reduzir duplicação de chamadas a `session[:…]`      |

| Nome da Model                                    | Score Antes | Score Depois | Refatoração Aplicada                     |
|--------------------------------------------------|:-----------:|:------------:|:----------------------------------------|
| — nenhuma model com método ABC ≥ 20 nesta sprint |      —      |      —       | —                                        |

---

## Cobertura de Testes (SimpleCov)

Todos os arquivos de controllers/models desenvolvidos na sprint alcançaram cobertura **> 90%**:

- **`Admin::ImportsController`**: 95.0%  
- **`SenhaDefinicaoController`**: 93.8%  
- **`GerenciamentoController`**: 95.8%  

> *(Caso haja outros controllers/models implementados nesta sprint, adicione-os aqui com seu percentual.)*

---

## Documentação (RDoc)

Todos os controllers, services e models criados/alterados foram documentados com RDoc:

- **Controllers**  
  - `Admin::ImportsController`  
  - `SenhaDefinicaoController`  
  - `GerenciamentoController`  

- **Services**  
  - `Admin::ImportSigaaService`  
  - `Admin::ImportCoursesService`  
  - `Admin::ImportParticipantsService`  
  - `Admin::CreateUserService`  
  - `Admin::PasswordDefinitionMailerService`  
  - `Admin::DefinePasswordService`  

- **Models**  
  - `Course`  
  - `Subject`  

Cada método possui:
1. **Descrição breve**  
2. **`@param`** para argumentos  
3. **`@return`** para valores de retorno  
4. **`@note`** ou **`@raise`** para efeitos colaterais / exceções  

Rode:

```bash
bundle exec rdoc \
  app/controllers/admin/imports_controller.rb \
  app/controllers/senha_definicao_controller.rb \
  app/controllers/gerenciamento_controller.rb \
  app/services/admin/*.rb \
  app/models/course.rb \
  app/models/subject.rb \
  --output=doc