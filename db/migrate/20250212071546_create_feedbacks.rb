class CreateFeedbacks < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :comments_for_dinner
      t.string :comments_for_snack
      t.float :rating_for_dinner
      t.float :rating_for_snack

      t.timestamps
    end
  end
end
