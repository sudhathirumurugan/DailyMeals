class CreateDailyMealRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_meal_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.boolean :snack
      t.boolean :dinner
      t.integer :chapati_count

      t.timestamps
    end
  end
end
