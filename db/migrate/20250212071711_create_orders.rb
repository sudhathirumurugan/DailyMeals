class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :total_snacks
      t.integer :total_dinners
      t.integer :total_chapatis

      t.timestamps
    end
  end
end
