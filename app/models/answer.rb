class Answer < ApplicationRecord
  belongs_to :form
  belongs_to :user
  belongs_to :question

  # 1. Validação de PERMISSÃO (Executada primeiro)
  # Garante que o usuário tem a permissão correta para o formulário.
  validate :user_role_matches_form_role
  validate :form_and_question_are_same_template
  validate :form_must_be_active

  # 2. Validações de FORMATO (Executadas apenas se a permissão estiver OK)
  # Usamos 'with_options' para agrupar e simplificar as condições.
  with_options if: -> { question&.alternative? } do
    validates :answer_alternative, presence: true
    validates :answer_text, absence: true
  end

  with_options if: -> { question&.text? } do
    validates :answer_text, presence: true
    validates :answer_alternative, absence: true
  end

  private

  # Método de validação personalizado para a permissão
  def user_role_matches_form_role
    # Cláusulas de guarda para evitar erros se as associações não existirem
    return if user.nil? || form.nil?

    # Compara a permissão do usuário com a do formulário
    if user.role != form.receiver_role
      # Adiciona um erro geral ao objeto, não a um campo específico
      errors.add(:base, "Você não tem permissão para responder este formulário.")
    end
  end

  def form_and_question_are_same_template
    return if form.nil? || question.nil?

    if form.template_id != question.template_id
      errors.add(:base, "Pergunta não existente no template")
    end
  end

  def form_must_be_active
    return if form.nil?

    unless form.active_status?
      # Adiciona o erro ao campo :form, pois o problema está no formulário associado.
      errors.add(:form, "não está ativo e não pode receber novas respostas.")
    end
  end
end
