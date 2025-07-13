class CreateForms < ActiveRecord::Migration[8.0]
  def change
    create_table :forms do |t|
      t.boolean :active_status
      t.integer :receiver_role
      t.references :subject, null: false, foreign_key: true
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
