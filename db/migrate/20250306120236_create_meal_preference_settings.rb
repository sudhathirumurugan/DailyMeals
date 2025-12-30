class CreateMealPreferenceSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :meal_preference_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.boolean :enabled, default: false
      t.timestamps
    end
  end
end
