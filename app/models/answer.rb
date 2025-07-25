# Representa uma resposta de usuário a uma questão de um formulário.
#
# Validações:
# 1️⃣ Permissão do usuário para responder (role vs. form.receiver_role)
# 2️⃣ Pertinência da pergunta ao template do formulário
# 3️⃣ Se o formulário está ativo
# 4️⃣ Se o tipo de pergunta exige texto ou alternativa
class Answer < ApplicationRecord
  belongs_to :form
  belongs_to :user
  belongs_to :question

  # 1️⃣ Validações de permissão (só roda quando form e user existem)
  validate :user_has_permission,     if: -> { user && form }
  validate :question_in_template,    if: -> { form && question }
  validate :form_must_be_active,     if: -> { form.present?   }

  # 2️⃣ Validações de formato (texto vs. alternativa)
  with_options if: -> { question&.alternative? } do
    validates :answer_alternative, presence: true
    validates :answer_text,        absence: true
  end

  with_options if: -> { question&.text? } do
    validates :answer_text,        presence: true
    validates :answer_alternative, absence: true
  end

  private

  # Adiciona um erro genérico ao objeto
  # @param message [String] texto da mensagem de erro
  def add_base_error(message)
    errors.add(:base, message)
  end

  # Garante que o usuário tenha a role correta para o formulário
  def user_has_permission
    return if user.role == form.receiver_role

    add_base_error("Você não tem permissão para responder este formulário.")
  end

  # Garante que a pergunta pertença ao mesmo template do formulário
  def question_in_template
    return if form.template_id == question.template_id

    add_base_error("Pergunta não existente no template.")
  end

  # Garante que o formulário esteja ativo
  def form_must_be_active
    return if form.active_status?

    errors.add(:form, "não está ativo e não pode receber novas respostas.")
  end
end
