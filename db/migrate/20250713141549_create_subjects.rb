class CreateSubjects < ActiveRecord::Migration[8.0]
  def change
    create_table :subjects do |t|
      t.string :class_name
      t.string :schedule
      t.string :semester
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
