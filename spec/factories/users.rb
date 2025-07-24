FactoryBot.define do
  factory :user do
    name { "Fulano Teste" }
    email { Faker::Internet.unique.email }
    username { Faker::Internet.username }
    hash_password { BCrypt::Password.create("senha123") }
    password_token { "abc123" }
    role { 0 }  # ou :student se for enum
    academic_background { 0 } # se necessário

    trait :student do
      role { :student }
      student_course { "Engenharia" }
      student_enrolment { "20220001" }
    end

    trait :professor do
      role { :professor }
      professor_departament { "Departamento de Computação" }
    end
  end
end
