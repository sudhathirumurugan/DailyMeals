class DailyMealRecord < ApplicationRecord
  belongs_to :user
  has_one :feedback
  has_many :feedbacks, dependent: :destroy 
  
  NOT_SPECIFIED = 0
  VEG = 1
  NON_VEG = 2

  # Validations
  validates :meal_type, inclusion: { in: [NOT_SPECIFIED, VEG, NON_VEG] }

  # Optionally, if you want to have a readable string version
  def meal_type_name
    case meal_type
    when VEG then "Veg"
    when NON_VEG then "Non-Veg"
    else "Not Specified!"
    end
  end

  # enum :meal_type, [ :veg, :non_veg ]



  validates :snack, :dinner, inclusion: { in: [ true, false, nil] }
  # validates :chapati_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :on_date, ->(date) { where(date: date) }
end
