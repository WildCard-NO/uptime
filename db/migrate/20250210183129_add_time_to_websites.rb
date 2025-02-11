class AddTimeToWebsites < ActiveRecord::Migration[7.1]
  def change
    add_column :websites, :time, :integer
  end
end
