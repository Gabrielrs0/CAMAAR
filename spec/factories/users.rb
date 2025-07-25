FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    hash_password { "123456" }
    sequence(:username) { |n| "user#{n}" }
    name { "Usuário Padrão" }

    trait :professor do
      role { :professor }
      sequence(:username) { |n| "professor#{n}" }
      # outros campos específicos do professor, se houver
    end

    trait :aluno do
      role { :aluno }
      sequence(:username) { |n| "aluno#{n}" }
      student_course { "Engenharia de Software" }
      student_enrolment { "2024012345" }
      name { "Aluno Padrão" }
    end
  end
end





# spec/factories/forms.rb
FactoryBot.define do
  factory :form do
    association :subject
    association :template
    active_status { true }
    receiver_role { :aluno }
  end
end

# spec/factories/subjects.rb
FactoryBot.define do
  factory :subject do
    class_name { "Engenharia de Software" }
    semester { "2024.1" }
    schedule { "Segunda 08:00" }
    course
  end
end



# spec/factories/courses.rb
FactoryBot.define do
  factory :course do
    code { "CIC0001" }
    name { "Engenharia de Computação" }
  end
end

# spec/factories/templates.rb
FactoryBot.define do
  factory :template do
    title { "Template de Teste" }
  end
end

# spec/factories/questions.rb
FactoryBot.define do
  factory :question do
    association :template
    content { "Pergunta de exemplo" }
    question_type { "text" } # ou o tipo correto do seu modelo
  end
end


# spec/factories/answers.rb
FactoryBot.define do
  factory :answer do
    association :form
    association :user
    association :question
    answer_text { "Resposta exemplo" }
  end
end
