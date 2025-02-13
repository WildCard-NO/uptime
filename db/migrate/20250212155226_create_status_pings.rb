class CreateStatusPings < ActiveRecord::Migration[6.0]
  def change
    create_table :status_pings do |t|
      t.integer :status_number
      t.references :website
      t.timestamps
    end
  end
end
