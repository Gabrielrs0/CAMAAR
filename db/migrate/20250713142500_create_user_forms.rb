class CreateUserForms < ActiveRecord::Migration[8.0]
  def change
    create_table :user_forms do |t|
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
