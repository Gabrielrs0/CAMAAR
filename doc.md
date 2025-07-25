## **RubyCritic** 

**Critérios de Refatoração**
- Identificar os métodos com ABC Score elevado por meio da ferramenta Flog (demonstra o score de cada metodo individualmente).
- Refatorar os métodos com score acima de 20.


| Nome da Controller | Score Anterior | Score Posterior | Refatoração Aplicada |
| --- | --- | --- | --- |
| `app/controllers/sessions_controller` | 29.77 | 32.64 | no método create (score anterior: 23.3, atual: 12.1) |
| `app/controllers/application_controller` | 11.15 | Não necessário | Não foi realizada refatoração | 
| `forms_controller` | 51.83 | 48.0 | no método generate_csv (score anterior: 21.0, atual: 14.9 ) |
| `app/controllers/admin/imports_controller.rb`    | 153.86 | 14.25   | Extrair lógica de importação em **services** (`ImportSigaaService`, `ImportCoursesService`, etc.)     |
| `app/controllers/senha_definicao_controller.rb`  | 28.74  | 8.00    | Mover lógica de definição de senha para `DefinePasswordService`; simplificar `update` e `edit`         |
| `app/controllers/gerenciamento_controller.rb`    | 42.62  | 11.42   | Unificar marcação de passos em métodos privados e reduzir duplicação de chamadas a `session[:…]`      |
| `Api::V1::TemplatesController`       | 19.97         | 19.88          | Remoção de comentários não descritivos e realocação do tratamento de erro no `set_template`. |

| Nome da Model                                    | Score Antes | Score Depois | Refatoração Aplicada                     |
| --- | --- | --- | --- |
| `Answer`      | 46.99       | 33.68        | Consolidado validações duplicadas em `with_options` e extração de métodos de validação. |

## **SimpleCov**

- SessionsController: 100% 
- models/User: 100%
- ApplicationController: 77.78%
- Admin::ImportsController: 95.0%  
- SenhaDefinicaoController: 93.8%  
- GerenciamentoController: 95.8%


## **Rdoc**

Todos os controllers, services e models criados/alterados foram documentados com RDoc:

- **Controllers**  
    - `Admin::ImportsController`  
    - `SenhaDefinicaoController`  
    - `GerenciamentoController`  
    - `SessionsController`
    - `ApplicationController`
    - `FormsController`
    -  `Api::V1::TemplatesController`

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
  - `User`
  - `Answer` 




