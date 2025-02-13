class ChangeStatusToIntegerInWebsites < ActiveRecord::Migration[6.1]
  def change
    change_column :websites, :status, :integer, using: 'CASE WHEN status = \'online\' THEN 1 ELSE 0 END'
  end
end
