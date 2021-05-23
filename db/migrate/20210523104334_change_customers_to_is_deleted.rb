class ChangeCustomersToIsDeleted < ActiveRecord::Migration[5.2]
  def change
    change_column(:customers, :is_deleted, :boolean, null: false, default: false)
  end
end
