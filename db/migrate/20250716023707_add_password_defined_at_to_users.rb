class AddPasswordDefinedAtToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :password_defined_at, :datetime
  end
end
