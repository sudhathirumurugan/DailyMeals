class RemoveDailyMealRecordIdFromFeedbacks < ActiveRecord::Migration[8.0]
  def change
    if column_exists?(:feedbacks, :daily_meal_record_id)
      remove_foreign_key :feedbacks, :daily_meal_records, name: "fk_feedbacks_daily_meal_record" rescue nil
      remove_column :feedbacks, :daily_meal_record_id, :bigint
    end
  end
end
