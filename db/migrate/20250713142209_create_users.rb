class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :hash_password
      t.integer :role
      t.integer :academic_background
      t.string :student_course
      t.string :student_enrolment
      t.string :professor_departament

      t.timestamps
    end
  end
end
