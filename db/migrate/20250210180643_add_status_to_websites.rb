class AddStatusToWebsites < ActiveRecord::Migration[7.1]
  def change
    add_column :websites, :status, :string
  end
end
