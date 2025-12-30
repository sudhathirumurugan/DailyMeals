class AddDailyMealRecordToFeedbacks < ActiveRecord::Migration[8.0]
  def change
    add_reference :feedbacks, :daily_meal_record, foreign_key: true
  end
end
