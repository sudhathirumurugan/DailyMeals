class AddMealTypeToDailyMealRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :daily_meal_records, :meal_type, :integer, default:nil 
  end
end
