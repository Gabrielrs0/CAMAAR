class RenameAdminToAdministrator < ActiveRecord::Migration[8.0]
  def change
     rename_table :admins, :administrators
  end
end
