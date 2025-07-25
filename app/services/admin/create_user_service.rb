
# Namespace Admin: serviços administrativos do sistema
# Service CreateUserService: cria ou encontra usuários, gera token e envia e-mail de definição de senha
module Admin
  class CreateUserService
    include Callable

    # Inicializa o serviço de criação de usuário
    # @param attrs [Hash] Atributos extraídos do JSON (nome, email, etc.)
    # @param role [Symbol] :student ou :professor
    def initialize(attrs, role)
      @attrs = attrs
      @role  = role
    end

    # Cria ou encontra o usuário e dispara e-mail de definição de senha
    # @return [User] Usuário persistido
    def call
      email = @attrs['email']
      user  = User.find_or_create_by!(email: email) do |u|
        u.name                = @attrs['nome']
        u.username            = @attrs['usuario'] || @attrs['matricula']
        u.role                = @role
        u.academic_background = User.map_academic_background(@attrs['formacao'])
        assign_role_specific(u)
        u.password_token      = SecureRandom.urlsafe_base64(32)
        u.hash_password       = BCrypt::Password.create(SecureRandom.hex(10))
      end

      Admin::PasswordDefinitionMailerService.call(user)
      user
    end

    private

    # Ajusta atributos específicos do papel (student ou professor)
    # @param user [User]
    # @return [void]
    def assign_role_specific(user)
      if @role == :student
        user.student_course    = @attrs['curso']
        user.student_enrolment = @attrs['matricula']
      else
        user.professor_departament = @attrs['departamento']
      end
    end
  end
end