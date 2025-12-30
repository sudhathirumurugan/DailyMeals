# require 'roo'

class Employee < User  # Assuming Employee inherits from User (STI)
  has_many :daily_meal_records, foreign_key: "user_id", dependent: :destroy
  has_many :feedbacks, foreign_key: "user_id", dependent: :destroy
end
